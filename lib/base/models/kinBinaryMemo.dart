import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/services.dart';

class KinBinaryMemo {
  KinBinaryMemo(int magicByteIndicator, int version, TransferType typeId, int appIdx, String foreignKey) {}
}

class TransferType {
  TransferType(int value) {}

  //TODO: if -1 return type Unknown

  //TODO: if 0 return type none

  //TODO: if 1 return type earn

  //TODO: if 2 return type spend

  //TODO: if 3 return type P2P
}

class Builder {
  int magicByteIndicator;
  int version;

  TransferType _typeId;
  ByteData _foreignKeyBytes;


  Builder(int appIdx, [this.magicByteIndicator = 1, this.version = 0]) { 
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
    if(_typeId.value < 0 || _typeId.value >= _typeIdMaxSize) {
      throw KinBinaryMemoFormatException(                    
        "typeId of ${_typeId.value} invalid! must be " +
        "larger than zero and less than $_typeIdMaxSize");
    }
  }

}