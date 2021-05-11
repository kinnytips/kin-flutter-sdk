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
    throw Exception('Illegal Argument Exception');
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

///@JvmName("contentHashCodeNullable")
///fun FixedByteArray?.contentHashCode(): Int = java.util.Arrays.hashCode(this?.byteArray)
///
///@JvmName("contentEqualsNullable")
///infix fun FixedByteArray?.contentEquals(other: FixedByteArray?): Boolean =
///java.util.Arrays.equals(this?.byteArray, other?.byteArray)

class FixedByteArray32 extends FixedByteArray {
  FixedByteArray32([Uint8List byteArray]) : super(byteArray ?? Uint8List(32)) ;

  @override
  int size() => 32;

  @override
  String toString() => "FixedByteArray32(bytes=${byteArray.toHexString()})";
}

class FixedByteArray64 extends FixedByteArray {
  Uint8List byteArray;

  FixedByteArray64({this.byteArray}) : super(byteArray) {
    this.byteArray = Uint8List(64);
  }

  @override
  int size() => 64;

  @override
  String toString() => "FixedByteArray64(bytes=${byteArray.toHexString()})";
}
