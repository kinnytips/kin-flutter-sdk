import 'dart:ffi';
import 'dart:typed_data';
import 'extensions.dart';

import 'package:kin_sdk/codec/base_n_codec.dart';

const BITS_PER_ENCODED_BYTE = 6;
const BYTES_PER_UNENCODED_BLOCK = 3;
const BYTES_PER_ENCODED_BLOCK = 4;
const MASK_6BITS = 0x3f;
const DEFAULT_PAD = "=";
const STANDARD_ENCODE_TABLE =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

/// [RFC 2045 section 2.1](http://www.ietf.org/rfc/rfc2045.txt)
/// decimal value for ['\r', '\n]
// const CHUNK_SEPARATOR = Uint8List.fromList([13, 10]);

const encodeSize = 0;
const decodeSize = 0;
const DECODE_TABLE = [
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  62,
  -1,
  62,
  -1,
  63,
  52,
  53,
  54,
  55,
  56,
  57,
  58,
  59,
  60,
  61,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  -1,
  -1,
  -1,
  -1,
  63,
  -1,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
  34,
  35,
  36,
  37,
  38,
  39,
  40,
  41,
  42,
  43,
  44,
  45,
  46,
  47,
  48,
  49,
  50,
  51
];

class Base64 extends BaseNCodec {
  Uint8List encodeTable;
  Uint8List lineSeparator;
  int bitWorkArea = 0;

  Base64({
    int lineLength = 0,
    Uint8List lineSeparator,
    bool urlSafe = false,
    int encodeSize = 0,
    int decodeSize = 0,
    int bitWorkArea = 0,
    Uint8List decodeTable,
  }) : super(BYTES_PER_UNENCODED_BLOCK, BYTES_PER_ENCODED_BLOCK, lineLength,
            lineSeparator.length ?? 0);

  @override
  void decoding(Uint8List pArray, int i, int length) {
    var inPos = i;
    if (eof) {
      return;
    }
    if (length < 0) {
      eof = true;
    }
    for (int i = 0; i < length; i++) {
      ensureBufferSize(decodeSize);
      var b = pArray[inPos++];
      if (b == byteArrayFromString(DEFAULT_PAD)[0]) {
        eof = true;
        break;
      } else {
        if (b >= 0 && b < DECODE_TABLE.length) {
          var result = DECODE_TABLE[b.toInt()].toInt();
          if (result >= 0) {
            modulus = (modulus + 1) % BYTES_PER_ENCODED_BLOCK;
            bitWorkArea = (bitWorkArea << BITS_PER_ENCODED_BYTE) + result;
            if (modulus == 0) {
              buffer[pos++] = (bitWorkArea >> 16 & MASK_6BITS).toSigned(8);
              buffer[pos++] = (bitWorkArea >> 8 & MASK_6BITS).toSigned(8);
              buffer[pos++] = (bitWorkArea & MASK_6BITS).toSigned(8);
            }
          }
        }
      }
    }

    if (eof && modulus != 0) {
      ensureBufferSize(decodeSize);
      switch (modulus) {
        case 2:
          bitWorkArea = bitWorkArea >> 4;
          buffer[pos++] = (bitWorkArea & MASK_6BITS).toSigned(8);
          break;
        case 3:
          bitWorkArea = bitWorkArea >> 2;
          buffer[pos++] = (bitWorkArea >> 8 & MASK_6BITS).toSigned(8);
          buffer[pos++] = (bitWorkArea & MASK_6BITS).toSigned(8);
          break;
      }
    }
  }

  @override
  void encoding(Uint8List pArray, int i, int length) {
    var inPos = i;
    if (eof) {
      return;
    }
    if (length < 0) {
      eof = true;
      if (0 == modulus && lineLength == 0) {
        return;
      }
      ensureBufferSize(encodeSize);
      var savedPos = pos;

      switch (modulus) {
        case 1:
          buffer[pos++] = encodeTable[bitWorkArea >> 2 & MASK_6BITS];
          buffer[pos++] = encodeTable[bitWorkArea << 4 & MASK_6BITS];
          if (encodeTable
              .contentEquals(byteArrayFromString(STANDARD_ENCODE_TABLE))) {
            buffer[pos++] = byteArrayFromString(DEFAULT_PAD)[0];
            buffer[pos++] = byteArrayFromString(DEFAULT_PAD)[0];
          }
          break;
        case 2:
          buffer[pos++] = encodeTable[bitWorkArea >> 10 & MASK_6BITS];
          buffer[pos++] = encodeTable[bitWorkArea >> 4 & MASK_6BITS];
          buffer[pos++] = encodeTable[bitWorkArea << 2 & MASK_6BITS];
          if (encodeTable
              .contentEquals(byteArrayFromString(STANDARD_ENCODE_TABLE))) {
            buffer[pos++] = byteArrayFromString(DEFAULT_PAD)[0];
          }
          break;
      }
      currentLinePos += pos - savedPos;
      if (lineLength > 0 && currentLinePos > 0) {
        List.copyRange(buffer, pos, lineSeparator, 0, lineSeparator.length);
        pos += lineSeparator.length;
      }
    } else {
      for (int i = 0; i < length; i++) {
        ensureBufferSize(encodeSize);
        modulus = (modulus + 1) % BYTES_PER_UNENCODED_BLOCK;
        var b = pArray[inPos++].toInt();
        if (b < 0) {
          b += 256;
        }
        bitWorkArea = (bitWorkArea << 8) + b;
        if (modulus == 0) {
          buffer[pos++] = encodeTable[bitWorkArea >> 18 & MASK_6BITS];
          buffer[pos++] = encodeTable[bitWorkArea >> 12 & MASK_6BITS];
          buffer[pos++] = encodeTable[bitWorkArea >> 6 & MASK_6BITS];
          buffer[pos++] = encodeTable[bitWorkArea & MASK_6BITS];

          currentLinePos += BYTES_PER_ENCODED_BLOCK;
          if (lineLength >= 1 && lineLength <= currentLinePos) {
            List.copyRange(buffer, pos, lineSeparator, 0, lineSeparator.length);
            pos += lineSeparator.length;
            currentLinePos = 0;
          }
        }
      }
    }
  }
}
