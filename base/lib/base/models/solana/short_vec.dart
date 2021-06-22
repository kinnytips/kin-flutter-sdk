import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:kin_base/base/models/solana/byte_utils.dart';
import 'package:kin_base/base/tools/byte_in_out_buffer.dart';

class ShortVec {
  static final ShortVec _shortVec = ShortVec._internal();

  factory ShortVec() => _shortVec;

  ShortVec._internal();

  static encodeShortVecOf<T>(ByteOutputBuffer output, List<T> elements,
      Uint8List Function(T) byteTransform) {
    encodeLen(output, elements.length);
    for (var element in elements) {
      var bs = byteTransform(element);
      output.writeAll(bs);
    }
  }

  static List<T> decodeShortVecOf<T>(ByteInputBuffer input, int sizeOfElement,
      [T Function(Uint8List) newInstance]) {
    newInstance ??= (e) => null ;

    final vecLength = decodeLen(input);
    final elements = <T>[];

    for (int i = 0; i < vecLength; i++) {
      Uint8List elemBytes = Uint8List(sizeOfElement);
      input.readTo(elemBytes, 0, sizeOfElement);
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
  static int encodeLen(ByteOutputBuffer output, int length) {
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
        output.write(valBuf.first);
        ++written;
        return written;
      }

      valBuf.first |= 0x80;
      output.write(valBuf.first);
      ++written;
    }
  }

  ///
  /// decodeLen decodes a ShortVec encoded [length] from the [input].
  ///
  /// @param input - the input stream that the length is encoded in
  /// @return - returns the decoded length of the ShortVec
  ///
  static int decodeLen(ByteInputBuffer input) {
    var offset = 0;
    var value = 0;

    while (true) {
      var b = input.read() & 0xff ;
      var i = b & 0x7f;
      var m = i << (offset * 7);
      value = value | m ;
      ++offset;

      if ((b & 0x80) == 0) break;
    }

    if (offset > 3) {
      throw Exception('RuntimeException: invalid size: $offset (max 3)');
    }

    return value;
  }
}
