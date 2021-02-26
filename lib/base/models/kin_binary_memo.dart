import 'dart:convert';
import 'dart:math';
import 'dart:scalarlist';
import 'package:flutter/services.dart';

class KinBinaryMemo {
  KinBinaryMemo(int magicByteIndicator, int version, TransferType typeId, int appIdx, String foreignKey) {

  }
  // ignore: non_constant_identifier_names
  int MASK_MAGIC_BYTE_INDICATOR = 0x3;
  // ignore: non_constant_identifier_names
  int MASK_VERSION = 0x1C;
  // ignore: non_constant_identifier_names
  int MASK_TYPE_ID = 0x3E0;
  // ignore: non_constant_identifier_names
  int MASK_APP_IDX = 0x3FFFC00;

  // ignore: non_constant_identifier_names
  int BIT_LENGTH_MAGIC_BYTE_INDICATOR = 2;
  // ignore: non_constant_identifier_names
  int BIT_LENGTH_VERSION = 3;
  // ignore: non_constant_identifier_names
  int BIT_LENGTH_TYPE_ID = 5;
  // ignore: non_constant_identifier_names
  int BIT_LENGTH_APP_IDX = 16;
  // ignore: non_constant_identifier_names
  int BIT_LENGTH_FOREIGN_KEY = 230;

  // ignore: non_constant_identifier_names
  int BIT_OFFSET_MAGIC_BYTE_INDICATOR = 0;
  // ignore: non_constant_identifier_names
  int BIT_OFFSET_VERSION() {
    return BIT_LENGTH_MAGIC_BYTE_INDICATOR;
  }
  // ignore: non_constant_identifier_names
  int BIT_OFFSET_TYPE_ID() {
    return (BIT_OFFSET_VERSION.call() + BIT_LENGTH_VERSION);
  } 
  // ignore: non_constant_identifier_names
  int BIT_OFFSET_APP_IDX() {
    return (BIT_OFFSET_TYPE_ID.call() + BIT_LENGTH_TYPE_ID);
  }
  // ignore: non_constant_identifier_names
  int BIT_OFFSET_FOREIGN_KEY()
  {
    return (BIT_OFFSET_APP_IDX.call() + BIT_LENGTH_APP_IDX);
  } 

  // ignore: non_constant_identifier_names
  int BYTE_COUNT_LOWER_BYTES() {
    return ((BIT_LENGTH_MAGIC_BYTE_INDICATOR + BIT_LENGTH_VERSION + BIT_LENGTH_TYPE_ID + BIT_LENGTH_APP_IDX) / 8).ceil().toInt();
  }
  // ignore: non_constant_identifier_names
  int BYTE_COUNT_FOREIGN_KEY() {
    return (BIT_LENGTH_FOREIGN_KEY / 8).ceil().toInt();
  }
  // ignore: non_constant_identifier_names
  int BYTE_COUNT_TOTAL() {
    return ((BIT_LENGTH_MAGIC_BYTE_INDICATOR + BIT_LENGTH_VERSION + BIT_LENGTH_TYPE_ID + BIT_LENGTH_APP_IDX + BIT_LENGTH_FOREIGN_KEY) / 8).ceil().toInt();
  }
  
  // ignore: non_constant_identifier_names
  int BYTE_OF_FK_START()
  {
    return (BIT_OFFSET_FOREIGN_KEY.call() / 8).floor().toInt();
  } 

  //TODO: Finish converting this
  // KinBinaryMemo decode(ByteData bytes)) = with(bytes.subByteArray(0, 4).byteArrayToInt()) {
  //     val magicByteIndicator =
  //         this and MASK_MAGIC_BYTE_INDICATOR ushr BIT_OFFSET_MAGIC_BYTE_INDICATOR
  //     val version = this and MASK_VERSION ushr BIT_OFFSET_VERSION
  //     val typeId = TransferType.fromValue(this and MASK_TYPE_ID ushr BIT_OFFSET_TYPE_ID)
  //     val appIdx = this and MASK_APP_IDX ushr BIT_OFFSET_APP_IDX

  //     val foreignKey = ByteArray(29)
  //     for (i in 0..27) {
  //         foreignKey[i] = foreignKey[i] or (bytes[i + 3] ushr 2) and 0x3F
  //         foreignKey[i] = foreignKey[i] or ((bytes[i + 4] and 0x3) shl 6)
  //     }
  //     foreignKey[28] = foreignKey[28] or ((bytes[31] ushr 2) and 0x3F)

  //     KinBinaryMemo(
  //         magicByteIndicator,
  //         version,
  //         typeId,
  //         appIdx,
  //         Base64().encodeAsString(foreignKey)
  //     )
  //   }

    ByteData foreignKeyBytes() {
        base64.decode(foreignKey)
        
            subByteArray(0, 29)
            .apply { set(28, get(28) and 0x3F.toByte()) }
    }

  //   /**
  //    * Fields below are packed from LSB to MSB order:
  //    *
  //    * magicByteIndicator    2 bits   | < 4
  //    * version               3 bits   | < 8
  //    * typeId                5 bits   | < 32
  //    * appIdx                16 bits  | < 65,536
  //    * foreignKey            230 bits | Often a SHA-224 of an [InvoiceList] but could be anything
  //    */
  //   fun encode(): ByteArray = ByteArray(BYTE_COUNT_TOTAL).apply {
  //       val lowerBytes =
  //           ((magicByteIndicator shl BIT_OFFSET_MAGIC_BYTE_INDICATOR and MASK_MAGIC_BYTE_INDICATOR)
  //                   or (version shl BIT_OFFSET_VERSION and MASK_VERSION)
  //                   or (typeId.value shl BIT_OFFSET_TYPE_ID and MASK_TYPE_ID)
  //                   or (appIdx shl BIT_OFFSET_APP_IDX and MASK_APP_IDX))
  //               .intToByteArray()
  //       System.arraycopy(lowerBytes, 0, this, 0, BYTE_COUNT_LOWER_BYTES)

  //       this[BYTE_OF_FK_START] = this[BYTE_OF_FK_START] or ((foreignKeyBytes[0] and 0x3F) shl 2)
  //       // insert the rest of the fk. since each loop references fk[n] and fk[n+1],
  //       // the upper bound is offset by 3 instead of 4.
  //       for (i in (BYTE_OF_FK_START + 1)..(2 + foreignKeyBytes.size)) {
  //           this[i] = this[i] or ((foreignKeyBytes[i - 4] ushr 6) and 0x3)
  //           this[i] = this[i] or (foreignKeyBytes[i - 3] and 0x3F shl 2)
  //       }
  //       // if the foreign key is less than 29 bytes,
  //       // the last 2 bits of the FK can be included in the memo
  //       if (foreignKeyBytes.size < 29) {
  //           this[BYTE_OF_FK_START + foreignKeyBytes.size] =
  //               ((foreignKeyBytes[foreignKeyBytes.size - 1] ushr 6)) and 0x3
  //       }
  //   }

  toKinMemo(){
    return KinMemo(encode());
  } 

  String toString() {
      return "AgoraMemo(magicByteIndicator=$magicByteIndicator, " +
              "version=$version, " +
              "typeId=${typeId.value}, " +
              "appIdx=$appIdx, " +
              "foreignKey='$foreignKey')"
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
    }
  }

    static int getValue(TransferType type) {
    switch(type) {
      case TransferType.unknown: return -1;
      case TransferType.none: return 0;
      case TransferType.earn: return 1;
      case TransferType.spend: return 2;
      case TransferType.p2p: return 3;
    }
  }
}

class Builder {
  int magicByteIndicator;
  int version;
  int appIdx;

  TransferType _typeId;
  ByteData _foreignKeyBytes;


  Builder(this.appIdx, [this.magicByteIndicator = 1, this.version = 0]) { 
  }

  setTransferType(TransferType typeId) {
    this._typeId = typeId;
  }

  setForeginKey(ByteData foreignKeyBytes) {
    this._foreignKeyBytes = foreignKeyBytes;
  }

  KinBinaryMemo build() {
    if (_typeId == null) {
      throw KinBinaryMemoFormatException("typeId must not be null!");
    }

    if (_foreignKeyBytes == null) {
      _foreignKeyBytes = ByteData(0);
    }

    int _typeIdMaxSize = pow(2, 5).toInt();
    if(TransferTypeUtil.getValue(_typeId) < 0 || TransferTypeUtil.getValue(_typeId) >= _typeIdMaxSize) {
      int typeValue = TransferTypeUtil.getValue(_typeId);
      throw KinBinaryMemoFormatException(
        "typeId of $typeValue invalid! must be " +
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

    ByteData foreignKeyBytesPadded = ByteData(BYTE_COUNT_FOREIGN_KEY);

    //TODO: IDK HOW TO DO THIS
      // Pad with zeros or truncate foreignKeyBytes
      // ByteData foreignKeyBytesPadded = ByteData(BYTE_COUNT_FOREIGN_KEY)
      // System.arraycopy(
      //     foreignKeyBytes!!, 0, foreignKeyBytesPadded, 0,
      //     min(foreignKeyBytesPadded.size, foreignKeyBytes!!.size)
      // )
      // trim last two bits, they don't fit
      // foreignKeyBytesPadded. = foreignKeyBytesPadded[28] + 0x3F.toByte()

    return KinBinaryMemo(
        magicByteIndicator,
        version,
        _typeId,
        appIdx,
        base64.encode(foreignKeyBytesPadded.buffer.asUint8List())
    );
  }
}

class KinBinaryMemoFormatException implements Exception {
  String message;
  KinBinaryMemoFormatException(this.message);
}