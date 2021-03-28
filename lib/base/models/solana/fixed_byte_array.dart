import 'dart:typed_data';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:kin_sdk/base/tools/byte_utils.dart';

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

  operator []=(int i, int val) => byteArray[i] = val;

  @override
  bool operator ==(Object other) {
    if (this == other) return true;
    // todo are next 2 lines equivalent?
    ///kotlin: if (javaClass != other?.javaClass) return false
    if (this.runtimeType != other?.runtimeType) return false;
    if (other is FixedByteArray) {
      if (!ListEquality().equals(byteArray, other.byteArray)) return false;
    } else {
      return false;
    }

    return true;
  }

  @override
  int get hashCode => hashList(byteArray);
}

///@JvmName("contentHashCodeNullable")
///fun FixedByteArray?.contentHashCode(): Int = java.util.Arrays.hashCode(this?.byteArray)
///
///@JvmName("contentEqualsNullable")
///infix fun FixedByteArray?.contentEquals(other: FixedByteArray?): Boolean =
///java.util.Arrays.equals(this?.byteArray, other?.byteArray)

class FixedByteArray32 extends FixedByteArray {
  Uint8List byteArray;

  FixedByteArray32(this.byteArray) : super(byteArray) {
    this.byteArray = Uint8List(32);
  }

  @override
  int size() => 32;

  @override
  String toString() => "FixedByteArray32(bytes=${byteArray.toHexString()})";
}

class FixedByteArray64 extends FixedByteArray {
  Uint8List byteArray;

  FixedByteArray64(this.byteArray) : super(byteArray) {
    this.byteArray = Uint8List(64);
  }

  @override
  int size() => 64;

  @override
  String toString() => "FixedByteArray64(bytes=${byteArray.toHexString()})";
}
