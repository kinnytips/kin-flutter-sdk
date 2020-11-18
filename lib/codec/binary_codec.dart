import 'dart:typed_data';

abstract class BinaryCoder {
  Uint8List encode(Uint8List source);
  Uint8List decode(String pArray);
}
