import 'dart:typed_data';

extension IntAsByteData on int {
  ByteData toByte() => ByteData(1)..setInt8(0, this);
}

extension ByteDataAsInt on ByteData {
  int toInt() => this.getInt8(0);
}
