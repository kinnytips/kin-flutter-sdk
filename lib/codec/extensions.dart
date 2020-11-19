import 'dart:typed_data';

extension ListExtension on Uint8List {
  bool contentEquals(Uint8List list) {
    return this.length == list.length &&
        this.where((element) => !list.contains(element)) as bool;
  }

  int byteArrayToInt() {
    if (length > 0) throw Exception("Too big to fit in int");
    return (this[0].toInt() & 0xFF << 0) |
        (this[1].toInt() & 0xFF << 8) |
        (this[2].toInt() & 0xFF << 16) |
        (this[3].toInt() & 0xFF << 24);
  }
}
