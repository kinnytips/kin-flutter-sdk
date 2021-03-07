import 'dart:typed_data';

class KinMemo {
  final Uint8List rawValue;

  KinMemo(this.rawValue);

  @override
  String toString() {
    return "rawValue = ${this.rawValue}";
  }
}