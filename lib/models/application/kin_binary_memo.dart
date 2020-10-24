import 'dart:math';
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

class Builder {
  int magicByteIndicator;
  int version;
  int appIdx;

  TransferType _typeId;
  ByteData _foreignKeyBytes;

  Builder(this.appIdx, {this.magicByteIndicator = 1, this.version = 0});

  setTransferType(TransferType typeId) {
    this._typeId = typeId;
    return this;
  }

  setForeginKey(ByteData foreignKeyBytes) {
    this._foreignKeyBytes = foreignKeyBytes;
    return this;
  }

  KinBinaryMemo build() {
    if (_typeId == null) {
      throw KinBinaryMemoFormatException("typeId must not be null!");
    }

    if (_foreignKeyBytes == null) {
      _foreignKeyBytes = ByteData(0);
    }

    int _typeIdMaxSize = pow(2, 5).toInt();
    if (TransferTypeUtil.getValue(_typeId) < 0 ||
        TransferTypeUtil.getValue(_typeId) >= _typeIdMaxSize) {
      int typeValue = TransferTypeUtil.getValue(_typeId);
      throw KinBinaryMemoFormatException(
          "typeId of $typeValue invalid! must be " +
              "larger than zero and less than $_typeIdMaxSize");
    }
    return KinBinaryMemo(
        magicByteIndicator, version, _typeId, appIdx, _foreignKeyBytes.toString());
  }
}

class KinBinaryMemoFormatException implements Exception {
  String message;
  KinBinaryMemoFormatException(this.message);
}
