import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:kin_base/base/tools/extensions.dart';

import 'kin_memo.dart';

class KinBinaryMemo {

  final int magicByteIndicator ;
  final int  version;
  final TransferType typeId ;
  final int  appIdx;
  final String foreignKey;

  KinBinaryMemo(this.magicByteIndicator, this.version, this.typeId, this.appIdx, this.foreignKey);

  // ignore: non_constant_identifier_names
  static const int MASK_MAGIC_BYTE_INDICATOR = 0x3;
  // ignore: non_constant_identifier_names
  static const int MASK_VERSION = 0x1C;
  // ignore: non_constant_identifier_names
  static const int MASK_TYPE_ID = 0x3E0;
  // ignore: non_constant_identifier_names
  static const int MASK_APP_IDX = 0x3FFFC00;

  // ignore: non_constant_identifier_names
  static const int BIT_LENGTH_MAGIC_BYTE_INDICATOR = 2;
  // ignore: non_constant_identifier_names
  static const int BIT_LENGTH_VERSION = 3;
  // ignore: non_constant_identifier_names
  static const int BIT_LENGTH_TYPE_ID = 5;
  // ignore: non_constant_identifier_names
  static const int BIT_LENGTH_APP_IDX = 16;
  // ignore: non_constant_identifier_names
  static const int BIT_LENGTH_FOREIGN_KEY = 230;

  // ignore: non_constant_identifier_names
  static const int BIT_OFFSET_MAGIC_BYTE_INDICATOR = 0;
  // ignore: non_constant_identifier_names
  static const int BIT_OFFSET_VERSION = BIT_LENGTH_MAGIC_BYTE_INDICATOR;

  // ignore: non_constant_identifier_names
  static const int BIT_OFFSET_TYPE_ID = BIT_OFFSET_VERSION + BIT_LENGTH_VERSION ;

  // ignore: non_constant_identifier_names
  static const int BIT_OFFSET_APP_IDX = BIT_OFFSET_TYPE_ID + BIT_LENGTH_TYPE_ID;

  // ignore: non_constant_identifier_names
  static const int BIT_OFFSET_FOREIGN_KEY = BIT_OFFSET_APP_IDX + BIT_LENGTH_APP_IDX ;

  // ignore: non_constant_identifier_names
  static final int BYTE_COUNT_LOWER_BYTES = ((BIT_LENGTH_MAGIC_BYTE_INDICATOR + BIT_LENGTH_VERSION + BIT_LENGTH_TYPE_ID + BIT_LENGTH_APP_IDX) / 8).ceil() ;

  // ignore: non_constant_identifier_names
  static final int BYTE_COUNT_FOREIGN_KEY = (BIT_LENGTH_FOREIGN_KEY / 8).ceil();

  // ignore: non_constant_identifier_names
  static final int BYTE_COUNT_TOTAL = ((BIT_LENGTH_MAGIC_BYTE_INDICATOR + BIT_LENGTH_VERSION + BIT_LENGTH_TYPE_ID + BIT_LENGTH_APP_IDX + BIT_LENGTH_FOREIGN_KEY) / 8).ceil() ;

  // ignore: non_constant_identifier_names
  static final int BYTE_OF_FK_START = (BIT_OFFSET_FOREIGN_KEY / 8).floor() ;

  KinBinaryMemo decode(Uint8List bytes) {
    var n = ByteData.view(bytes.buffer).getInt32(0) ;

    var magicByteIndicator = n & ( (MASK_MAGIC_BYTE_INDICATOR & 0xFFFFFFFF) >> BIT_OFFSET_MAGIC_BYTE_INDICATOR) ;
    var version = n & ( (MASK_VERSION & 0xFFFFFFFF) >> BIT_OFFSET_VERSION);

    var typeId = TransferTypeUtil.getType( n & ((MASK_TYPE_ID & 0xFFFFFFFF) >> BIT_OFFSET_TYPE_ID) );

    var appIdx = n & ((MASK_APP_IDX & 0xFFFFFFFF) >> BIT_OFFSET_APP_IDX) ;

    var foreignKey = Uint8List(29);

    for (var i = 0; i <= 27; ++i) {
      foreignKey[i] = foreignKey[i] | ( (bytes[i + 3] & 0xFFFFFFFF) >> 2) & 0x3F ;
      foreignKey[i] = foreignKey[i] | ( ( (bytes[i + 4] & 0xFFFFFFFF) >> 0x3) << 6);
    }

    foreignKey[28] = foreignKey[28] | ( ( (bytes[31] & 0xFFFFFFFF) >> 2) & 0x3F);

    return KinBinaryMemo(
        magicByteIndicator,
        version,
        typeId,
        appIdx,
        base64.encode(foreignKey)
    );
  }

  Uint8List _foreignKeyBytes ;

  Uint8List get foreignKeyBytes {
    if (_foreignKeyBytes == null) {
      var bs = base64.decode(foreignKey).sublist(0, 29) ;
      bs[28] = bs[28] & 0x3F ;
      _foreignKeyBytes = bs ;
    }
    return _foreignKeyBytes ;
  }

  Uint8List encode() {
    var bs = Uint8List(BYTE_COUNT_TOTAL) ;

    var lowerBytes =
    (
        (magicByteIndicator << BIT_OFFSET_MAGIC_BYTE_INDICATOR & MASK_MAGIC_BYTE_INDICATOR)
        | (version << BIT_OFFSET_VERSION & MASK_VERSION)
        | (typeId.getValue() << BIT_OFFSET_TYPE_ID & MASK_TYPE_ID)
        | (appIdx << BIT_OFFSET_APP_IDX & MASK_APP_IDX)
    ).toInt32Uint8List() ;

    bs.setRange(0, BYTE_COUNT_LOWER_BYTES, lowerBytes);

    bs[BYTE_OF_FK_START] = bs[BYTE_OF_FK_START] | ((foreignKeyBytes[0] & 0x3F) << 2);

    // insert the rest of the fk. since each loop references fk[n] and fk[n+1],
    // the upper bound is offset by 3 instead of 4.
    for (var i = BYTE_OF_FK_START + 1; i <= 2 + foreignKeyBytes.length; ++i) {
      bs[i] = bs[i] | (( (foreignKeyBytes[i - 4] & 0xFFFFFFFF) >> 6) & 0x3);
      bs[i] = bs[i] | (foreignKeyBytes[i - 3] & 0x3F << 2);
    }

    if (foreignKeyBytes.length < 29) {
      bs[BYTE_OF_FK_START + foreignKeyBytes.length] = (( (foreignKeyBytes[foreignKeyBytes.length - 1] & 0xFFFFFFFF) >> 6)) & 0x3;
    }

    return bs ;
  }

  toKinMemo(){
    return KinMemo(encode());
  }

  String toString() {
      return "AgoraMemo(magicByteIndicator=$magicByteIndicator, " +
              "version=$version, " +
              "typeId=${typeId.getValue()}, " +
              "appIdx=$appIdx, " +
              "foreignKey='$foreignKey')";
  }
}

enum TransferType {
  unknown,
  none,
  earn,
  spend,
  p2p
}

extension TransferTypeUtil on TransferType {
  static TransferType getType(int value) {
    switch(value) {
      case -1: return TransferType.unknown;
      case 1: return TransferType.earn;
      case 2: return TransferType.spend;
      case 3: return TransferType.p2p;
      default: throw StateError("Invalid value: $value");
    }
  }

  int getValue() {
    switch(this) {
      case TransferType.unknown: return -1;
      case TransferType.none: return 0;
      case TransferType.earn: return 1;
      case TransferType.spend: return 2;
      case TransferType.p2p: return 3;
      default: return -1;
    }
  }
}

class KinBinaryMemoBuilder {
  int appIdx;
  int magicByteIndicator;
  int version;

  TransferType _typeId;
  Uint8List _foreignKeyBytes;

  KinBinaryMemoBuilder(this.appIdx, [this.magicByteIndicator = 1, this.version = 0]) ;

  void setTransferType(TransferType typeId) {
    this._typeId = typeId;
  }

  void setForeignKey(Uint8List foreignKeyBytes) {
    this._foreignKeyBytes = foreignKeyBytes;
  }

  KinBinaryMemo build() {
    if (_typeId == null) {
      throw KinBinaryMemoFormatException("typeId must not be null!");
    }

    if (_foreignKeyBytes == null) {
      _foreignKeyBytes = Uint8List(0);
    }

    int _typeIdMaxSize = pow(2, 5).toInt();
    var typeIdValue = _typeId.getValue();

    if(typeIdValue < 0 || typeIdValue >= _typeIdMaxSize) {
      throw KinBinaryMemoFormatException(
        "typeId of $typeIdValue invalid! must be " +
        "larger than zero and less than $_typeIdMaxSize");
    }

    int appIdxMaxSize = pow(2, 16).toInt();
    if(appIdx < 0 || appIdx >= appIdxMaxSize) {
      throw KinBinaryMemoFormatException(
        "appIdx of $appIdx invalid! must be " +
        "larger than zero and less than $appIdxMaxSize"
      );
    }

    int magicByteIndicatorMaxSize = pow(2, 2).toInt();
    if(magicByteIndicator < 0 || magicByteIndicator >= magicByteIndicatorMaxSize) {
        throw KinBinaryMemoFormatException(
          "magicByteIndicator of $magicByteIndicator invalid! must be" +
          "larger than zero and less than $magicByteIndicatorMaxSize"
      );
    }

    int versionMaxSize = pow(2, 3).toInt();
    if(version < 0 || version >= versionMaxSize) {
      throw KinBinaryMemoFormatException(
        "version of $version invalid! must be " +
        "larger than zero and less than $versionMaxSize"
      );
    }

    var foreignKeyBytesPadded = Uint8List(KinBinaryMemo.BYTE_COUNT_FOREIGN_KEY);

    foreignKeyBytesPadded.setRange(0, min(foreignKeyBytesPadded.length, _foreignKeyBytes.length), _foreignKeyBytes);

    foreignKeyBytesPadded[28] = foreignKeyBytesPadded[28] & 0x3F ;

    return KinBinaryMemo(
        magicByteIndicator,
        version,
        _typeId,
        appIdx,
        base64.encode(foreignKeyBytesPadded)
    );
  }
}

class KinBinaryMemoFormatException implements Exception {
  String message;
  KinBinaryMemoFormatException(this.message);
}