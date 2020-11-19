import 'dart:math';
import 'dart:typed_data';
import 'package:kin_sdk/codec/base_64.dart';
import 'package:kin_sdk/codec/extensions.dart';

import '../kin_memo.dart';

const MASK_MAGIC_BYTE_INDICATOR = 0x3;
const MASK_VERSION = 0x1C;
const MASK_TYPE_ID = 0x3E0;
const MASK_APP_IDX = 0x3FFFC00;

const BIT_LENGTH_MAGIC_BYTE_INDICATOR = 2;
const BIT_LENGTH_VERSION = 3;
const BIT_LENGTH_TYPE_ID = 5;
const BIT_LENGTH_APP_IDX = 16;
const BIT_LENGTH_FOREIGN_KEY = 230;

const BIT_OFFSET_MAGIC_BYTE_INDICATOR = 0;
const BIT_OFFSET_VERSION = BIT_LENGTH_MAGIC_BYTE_INDICATOR;
const BIT_OFFSET_TYPE_ID = BIT_OFFSET_VERSION + BIT_LENGTH_VERSION;
const BIT_OFFSET_APP_IDX = BIT_OFFSET_TYPE_ID + BIT_LENGTH_TYPE_ID;
const BIT_OFFSET_FOREIGN_KEY = BIT_OFFSET_APP_IDX + BIT_LENGTH_APP_IDX;

// ignore: non_constant_identifier_names
final BYTE_COUNT_LOWER_BYTES = ((BIT_LENGTH_MAGIC_BYTE_INDICATOR +
            BIT_LENGTH_VERSION +
            BIT_LENGTH_TYPE_ID +
            BIT_LENGTH_APP_IDX) /
        8)
    .ceil();

// ignore: non_constant_identifier_names
final BYTE_COUNT_FOREIGN_KEY = (BIT_LENGTH_FOREIGN_KEY / 8).ceil();
// ignore: non_constant_identifier_names
final BYTE_COUNT_TOTAL = ((BIT_LENGTH_MAGIC_BYTE_INDICATOR +
            BIT_LENGTH_VERSION +
            BIT_LENGTH_TYPE_ID +
            BIT_LENGTH_APP_IDX +
            BIT_LENGTH_FOREIGN_KEY) /
        8)
    .ceil();

// ignore: non_constant_identifier_names
final BYTE_OF_FK_START = (BIT_OFFSET_FOREIGN_KEY / 8).floor();

Uint8List int32bytes(int value) =>
    Uint8List(4)..buffer.asInt32List()[0] = value;

class KinBinaryMemo {
  final int magicByteIndicator;
  final int version;
  final TransferType typeId;
  final int appIdx;
  final String foreignKey;
  final Uint8List rawBytes;

  KinBinaryMemo._builder(KinBuilder builder)
      : magicByteIndicator = builder.magicByteIndicator,
        version = builder.version,
        typeId = builder._typeId,
        appIdx = builder.appIdx,
        foreignKey = Base64().encodeAsString(builder._foreignKeyBytes),
        rawBytes = builder._foreignKeyBytes;

  Uint8List getForeignKeyBytes() {
    Uint8List bytes = Base64(
            lineSeparator: Uint8List.fromList([13, 10]),
            decodeTable: Uint8List.fromList(DECODE_TABLE))
        .decode(foreignKey);
    List result = bytes.sublist(0, 29);
    result[28] = result[28] & int.parse("0x3F");
    return result;
  }

  Uint8List _encode() {
    var typeArray = List.filled(BYTE_COUNT_TOTAL, 0);
    var lowerBytes = int32bytes((magicByteIndicator <<
            (BIT_OFFSET_MAGIC_BYTE_INDICATOR & MASK_MAGIC_BYTE_INDICATOR)) |
        (version << BIT_OFFSET_VERSION & MASK_VERSION) |
        (TransferTypeUtil.getValue(typeId) << BIT_OFFSET_TYPE_ID &
            MASK_TYPE_ID) |
        (appIdx << BIT_OFFSET_APP_IDX & MASK_APP_IDX));
    List.copyRange(typeArray, 0, lowerBytes, 0, BYTE_COUNT_LOWER_BYTES);

    Uint8List foreignKeyBytes = getForeignKeyBytes();

    typeArray[BYTE_OF_FK_START] = typeArray[BYTE_OF_FK_START] |
        ((foreignKeyBytes[0] & int.parse("0x3F")) << 2).toSigned(8);

    for (var i = BYTE_OF_FK_START + 1; i < 2 + foreignKeyBytes.length; i++) {
      typeArray[i] =
          typeArray[i] | ((foreignKeyBytes[i - 4] >> 6) & int.parse("0x3"));
      typeArray[i] = typeArray[i] |
          ((foreignKeyBytes[i - 3] & int.parse("0x3F") << 2).toSigned(8));
    }
    if (foreignKeyBytes.length < 29) {
      typeArray[BYTE_OF_FK_START + foreignKeyBytes.length] =
          ((foreignKeyBytes[foreignKeyBytes.length - 1]) >> 6) &
              int.parse("0x3");
    }

    return Uint8List.fromList(typeArray);
  }

  KinBinaryMemo decode(Uint8List bytes) {
    int result = bytes.sublist(0, 4).byteArrayToInt();
    var magicByteIndicator =
        result & MASK_MAGIC_BYTE_INDICATOR >> BIT_OFFSET_MAGIC_BYTE_INDICATOR;
    var version = result & MASK_VERSION >> BIT_OFFSET_VERSION;
    var typeId =
        TransferTypeUtil.getType(result & MASK_TYPE_ID >> BIT_OFFSET_TYPE_ID);
    var appIdx = result & MASK_APP_IDX >> BIT_OFFSET_APP_IDX;
    var foreignKey = Uint8List(29);
    for (int i = 0; i <= 27; i++) {
      foreignKey[i] = foreignKey[i] | (bytes[i + 3] >> 2) & 0x3F;
      foreignKey[i] = foreignKey[i] | ((bytes[i + 4] & 0x3) << 6);
    }

    foreignKey[28] = foreignKey[28] | ((bytes[31] >> 2) & 0x3F);

    KinBinaryMemo memo = (KinBuilder(appIdx,
            magicByteIndicator: magicByteIndicator, version: version)
          ..setTransferType(typeId))
        .build();

    return memo;
  }

  KinMemo toKinMemo() => KinMemo(_encode());
}

enum TransferType { unknown, none, earn, spend, p2p }

extension TransferTypeUtil on TransferType {
  static TransferType getType(int value) {
    switch (value) {
      case -1:
        return TransferType.unknown;
      case 1:
        return TransferType.earn;
      case 2:
        return TransferType.spend;
      case 3:
        return TransferType.p2p;
      default:
        return TransferType.unknown;
    }
  }

  static int getValue(TransferType type) {
    switch (type) {
      case TransferType.unknown:
        return -1;
      case TransferType.none:
        return 0;
      case TransferType.earn:
        return 1;
      case TransferType.spend:
        return 2;
      case TransferType.p2p:
        return 3;
      default:
        return -1;
    }
  }
}

class KinBuilder {
  int magicByteIndicator;
  int version;
  int appIdx;

  TransferType _typeId;
  Uint8List _foreignKeyBytes;

  KinBuilder(this.appIdx, {this.magicByteIndicator = 1, this.version = 0});

  setTransferType(TransferType typeId) {
    this._typeId = typeId;
    return this;
  }

  setForeginKey(Uint8List foreignKeyBytes) {
    this._foreignKeyBytes = foreignKeyBytes;
    return this;
  }

  KinBinaryMemo build() {
    if (_typeId == null) {
      throw KinBinaryMemoFormatException("typeId must not be null!");
    }

    if (_foreignKeyBytes == null) {
      _foreignKeyBytes = Uint8List(0);
    }

    int _typeIdMaxSize = pow(2, 5).toInt();
    if (TransferTypeUtil.getValue(_typeId) < 0 ||
        TransferTypeUtil.getValue(_typeId) >= _typeIdMaxSize) {
      int typeValue = TransferTypeUtil.getValue(_typeId);
      throw KinBinaryMemoFormatException(
          "typeId of $typeValue invalid! must be " +
              "larger than zero and less than $_typeIdMaxSize");
    }

    int appIdxMaxSize = pow(2, 16).toInt();
    if (appIdx < 0 || appIdx >= appIdxMaxSize) {
      throw KinBinaryMemoFormatException("appIdx of $appIdx invalid! must be " +
          "larger than zero and less than $appIdxMaxSize");
    }

    int magicByteIndicatorMaxSize = pow(2, 2).toInt();
    if (magicByteIndicator < 0 ||
        magicByteIndicator >= magicByteIndicatorMaxSize) {
      throw KinBinaryMemoFormatException(
          "magicByteIndicator of $magicByteIndicator invalid! must be" +
              "larger than zero and less than $magicByteIndicatorMaxSize");
    }

    int versionMaxSize = pow(2, 3).toInt();
    if (version < 0 || version >= versionMaxSize) {
      throw KinBinaryMemoFormatException(
          "version of $version invalid! must be " +
              "larger than zero and less than $versionMaxSize");
    }

    // Pad with zeros or truncate foreignKeyBytes
    Uint8List foreignKeyBytesPadded = Uint8List(BYTE_COUNT_FOREIGN_KEY);
    List.copyRange(
        foreignKeyBytesPadded,
        0,
        _foreignKeyBytes,
        0,
        min(foreignKeyBytesPadded.lengthInBytes,
            _foreignKeyBytes.lengthInBytes));

    foreignKeyBytesPadded[28] =
        foreignKeyBytesPadded[28] & int.parse("0x3F").toSigned(8);

    return KinBinaryMemo._builder(this);
  }
}

class KinBinaryMemoFormatException implements Exception {
  String message;

  KinBinaryMemoFormatException(this.message);
}
