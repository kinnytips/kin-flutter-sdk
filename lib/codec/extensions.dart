import 'dart:typed_data';

extension ListExtension on Uint8List {
  bool contentEquals(Uint8List list) {
    return this.length == list.length &&
        this.where((element) => !list.contains(element)) as bool;
  }
}
