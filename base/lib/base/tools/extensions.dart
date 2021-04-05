import 'dart:typed_data';

extension IntExtension on int {
  ByteData toByte() => ByteData(1)..setInt8(0, this);
}

extension ByteDataExtension on ByteData {
  int toInt() => this.getInt8(0);
}

extension Uint8ListExtension on Uint8List {
  String toHexString() =>
      map((e) => e.toRadixString(16).padLeft(2, '0')).join();

  ByteData toByte() => ByteData.sublistView(this);
}

extension ListIntExtension on List<int> {
  int computeHashCode() {
    var h = 0;
    for (var e in this) {
      h = 31 * h + e;
    }
    return h;
  }
}
