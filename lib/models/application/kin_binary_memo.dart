import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class KinBinaryMemo {
  KinBinaryMemo(int magicByteIndicator, int version, TransferType typeId,
      int appIdx, String foreignKey);
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

final BYTE_COUNT_LOWER_BYTES = ((BIT_LENGTH_MAGIC_BYTE_INDICATOR +
            BIT_LENGTH_VERSION +
            BIT_LENGTH_TYPE_ID +
            BIT_LENGTH_APP_IDX) /
        8)
    .ceil();

final BYTE_COUNT_FOREIGN_KEY = (BIT_LENGTH_FOREIGN_KEY / 8).ceil();
final BYTE_COUNT_TOTAL = ((BIT_LENGTH_MAGIC_BYTE_INDICATOR +
            BIT_LENGTH_VERSION +
            BIT_LENGTH_TYPE_ID +
            BIT_LENGTH_APP_IDX +
            BIT_LENGTH_FOREIGN_KEY) /
        8)
    .ceil();

final BYTE_OF_FK_START = (BIT_OFFSET_FOREIGN_KEY / 8).floor();

class Builder {
  int magicByteIndicator;
  int version;
  int appIdx;

  TransferType _typeId;
  Uint8List _foreignKeyBytes;

  Builder(this.appIdx, {this.magicByteIndicator = 1, this.version = 0});

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

    return KinBinaryMemo(magicByteIndicator, version, _typeId, appIdx,
        _foreignKeyBytes.toString());
  }
}

class KinBinaryMemoFormatException implements Exception {
  String message;

  KinBinaryMemoFormatException(this.message);
}
