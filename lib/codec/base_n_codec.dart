import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:kin_sdk/codec/string_utils.dart';

import 'binary_codec.dart';

const defaultBufferSize = 8192;
const DEFAULT_BUFFER_RESIZE_FACTOR = 2;

abstract class BaseNCodec extends BinaryCoder {
  final int unencodedBlockSize;
  final int encodedBlockSize;
  final int chunkSeparatorLength;
  final int lineLen;
  Uint8List buffer;
  int pos;
  int readPos;
  bool eof;
  int currentLinePos = 0;
  int modulus;

  BaseNCodec(this.unencodedBlockSize, this.encodedBlockSize,
      this.chunkSeparatorLength, this.lineLen,
      {this.buffer,
      this.pos = 0,
      this.readPos = 0,
      this.eof = false,
      this.currentLinePos = 0,
      this.modulus = 0});

  int get lineLength => (lineLen > 0 && chunkSeparatorLength > 0)
      ? lineLength / encodedBlockSize * encodedBlockSize
      : 0;

  int get available => buffer != null ? pos - readPos : 0;

  void resizeBuffer() {
    if (buffer == null) {
      buffer = Uint8List(defaultBufferSize);
      pos = 0;
      readPos = 0;
    } else {
      var b = Uint8List(buffer.length * DEFAULT_BUFFER_RESIZE_FACTOR);
      List.copyRange(b, 0, buffer, 0, buffer.length);
      buffer = b;
    }
  }

  /// Ensure that the buffer has room for [size] bytes
  /// [size] minimum spare space required
  void ensureBufferSize(int size) {
    if (buffer == null || buffer.length < pos + size) {
      resizeBuffer();
    }
  }

  /// Extracts buffered data into the provided [Uint8List], starting at position [bPos],
  /// up to a maximum of [bAvail] bytes. Returns how many bytes were actually extracted.
  ///
  /// [b] byte array to extract the buffered data into
  /// [bPos] position in byte [] array to start extraction at.
  /// [bAvail] amount of bytes we're allowed to extract. We may extract fewer (if fewer are available)
  ///
  /// returns The number of bytes successfully extracted into the provided byte[] array.

  int readResults(Uint8List b, int bPos, int bAvail) {
    if (buffer != null) {
      var len = min(available, bAvail);
      List.copyRange(b, readPos, buffer, bPos, len);
      readPos += len;
      if (readPos >= pos) {
        this.buffer = null;
      }
      return len;
    }
    return eof ? -1 : 0;
  }

  void _reset() {
    buffer = null;
    pos = 0;
    readPos = 0;
    currentLinePos = 0;
    modulus = 0;
    eof = false;
  }

  @override
  Uint8List decode(String pArray) {
    return _decode(StringUtils.getBytesUtf8(pArray));
  }

  Uint8List _decode(Uint8List source) {
    _reset();
    if (source == null || source.isEmpty) {
      return source;
    }

    decoding(source, 0, source.length);
    decoding(source, 0, -1);
    var result = Uint8List(pos);
    readResults(result, 0, result.length);
    return result;
  }

  @override
  Uint8List encode(Uint8List source) {
    return _encode(source);
  }

  Uint8List _encode(Uint8List source) {
    _reset();
    if (source == null || source.isEmpty) {
      return source;
    }
    encoding(source, 0, source.length);
    encoding(source, 0, -1);
    var buf = Uint8List(pos - readPos);
    readResults(buf, 0, buf.length);
    return buf;
  }

  /// dart doesn't allow method name with same name
  /// kin-android-sdk's encode = encoding
  void encoding(Uint8List pArray, int i, int length);

  void decoding(Uint8List pArray, int i, int length);

  Uint8List byteArrayFromString(String params) {
    return Utf8Encoder().convert(params);
  }

  String encodeAsString(Uint8List pArray) {
    return StringUtils.newStringUtf8(encode(pArray));
  }
}
