import 'dart:ffi';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';

class ShortVec {
  static final ShortVec _shortVec = ShortVec._internal();

  factory ShortVec() => _shortVec;

  ShortVec._internal();

  // custom todo: make sure function is right (byteTransform: (T) -> ByteArray)
  static encodeShortVecOf(Uint8List output, List elements, Function byteTransform) {
    encodeLen(output, elements.length);
    elements.forEach((element) {
      output.addAll(byteTransform(element));
    });
  }

  // custom todo: make sure function is right (newInstance: (ByteArray) -> T? = { null })
  static List decodeShortVecOf(Uint8List input, int sizeOfElement, [Function newInstance(Uint8List l)]) {
    final vecLength = decodeLen(input);
    final elements = [];

    for (int i = 0; i < vecLength; i++) {
       Uint8List elemBytes = Uint8List(sizeOfElement);
      try {
        elemBytes = input.sublist(0, sizeOfElement);
      } catch (e) {
        throw Exception('RuntimeException: failed to read ${input.genericType} at $i');
      }
      elements.add(elemBytes.toModel(newInstance));
    }

    return elements;
  }

  static final int MAX_VALUE = Int32.MAX_VALUE.toInt();

  ///
  ///encodeLen encodes the specified [length] into the [output].
  ///
  /// @param output - the outputStream the length, of the ShortVec. is to be encoded in
  /// @return - the number of bytes written. If length > UShort.MAX_VALUE.toInt() , a [RuntimeException] is thrown
  ///
  static int encodeLen(Uint8List output, int length) {
    if (length > MAX_VALUE) {
      throw Exception('RuntimeException: length exceeds $MAX_VALUE');
    }

    var lengthLocal = length;
    final Uint8List valBuf = Uint8List(1);
    var written = 0;

    while (true) {
      valBuf.first = (lengthLocal & 0x7f);
      lengthLocal >>= 7;

      if (lengthLocal == 0) {
        output.addAll(valBuf);
        ++written;
        return written;
      }

      valBuf.first |= 0x80;
      output.addAll(valBuf);
      ++written;
    }
  }

  ///
  /// decodeLen decodes a ShortVec encoded [length] from the [input].
  ///
  /// @param input - the input stream that the length is encoded in
  /// @return - returns the decoded length of the ShortVec
  ///
  static int decodeLen(Uint8List input) {
    var offset = 0;
    final Uint8List valBuf = Uint8List(1);
    var value = 0;

    while (true) {
      valBuf.first = input.first;

      value |= (valBuf.first & 0x7f << (offset * 7));
      ++offset;

      if ((valBuf.first & 0x80) == 0) break;
    }

    if (offset > 3) {
      throw Exception('RuntimeException: invalid size: $offset (max 3)');
    }

    return value;
  }
}

extension ListTypedExtension<T> on List<T> {
  /// Provide access to the generic type at runtime.
  Type get genericType => T;
}
