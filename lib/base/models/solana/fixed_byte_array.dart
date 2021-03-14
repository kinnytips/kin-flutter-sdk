import 'dart:ui';

import 'package:collection/collection.dart';

import 'package:kin_sdk/base/tools/byte_utils.dart';


// TODO: This is an incomplete file!

abstract class FixedByteArray {
  final List<int> byteArray;

  // todo can this be abstract?
  abstract final int size;

  FixedByteArray(this.byteArray) {
    check();
  }

  bool check() {
    if (byteArray.length == size) return true;
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

      return true;
    }

    return false;
  }

  @override
  int get hashCode => hashList(byteArray);
}

// TODO: need to convert below lines
///@JvmName("contentHashCodeNullable")
///fun FixedByteArray?.contentHashCode(): Int = java.util.Arrays.hashCode(this?.byteArray)
///
///@JvmName("contentEqualsNullable")
///infix fun FixedByteArray?.contentEquals(other: FixedByteArray?): Boolean =
///java.util.Arrays.equals(this?.byteArray, other?.byteArray)

class FixedByteArray32 extends FixedByteArray {
  List<int> byteArray;

  FixedByteArray32(this.byteArray) : super(byteArray) {
    this.byteArray = []..length = 32;
  }

  @override
  final int size;

  @override
  String toString() => "FixedByteArray32(bytes=${byteArray.toHexString()})";
}

class FixedByteArray64 extends FixedByteArray {
  List<int> byteArray;

  FixedByteArray64(this.byteArray, this.size) : super(byteArray) {
    this.byteArray = []..length = 64;
  }

  @override
  final int size;

  @override
  String toString() => "FixedByteArray64(bytes=${byteArray.toHexString()})";
}
