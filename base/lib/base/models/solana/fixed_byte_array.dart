import 'dart:typed_data';

import 'package:kin_base/base/tools/extensions.dart';

abstract class FixedByteArray {
  final Uint8List byteArray;

  int size();

  FixedByteArray(this.byteArray) {
    check();
  }

  bool check() {
    if (byteArray.length == size()) return true;
    throw Exception('Illegal Argument Exception: byteArray:${ byteArray.length } != size:${ size() }');
  }

  operator [](int i) => byteArray[i];

  operator []=(int i, ByteData b) => byteArray[i] = b.getUint8(0);

  @override
  bool operator ==(Object other) {
    if (this == other) return true;
    if (this.runtimeType != other?.runtimeType) return false;
    if (other is FixedByteArray) {
      if (!byteArray.equalsContent(other.byteArray)) return false;
    } else {
      return false;
    }

    return true;
  }

  @override
  int get hashCode => byteArray.computeHashCode();
}

class FixedByteArray32 extends FixedByteArray {
  FixedByteArray32([Uint8List byteArray]) : super(byteArray ?? Uint8List(32)) ;

  @override
  int size() => 32;

  @override
  String toString() => "FixedByteArray32(bytes=${byteArray.toHexString()})";
}

class FixedByteArray64 extends FixedByteArray {

  FixedByteArray64([Uint8List byteArray]) : super(byteArray ?? Uint8List(64)) ;

  @override
  int size() => 64;

  @override
  String toString() => "FixedByteArray64(bytes=${byteArray.toHexString()})";
}
