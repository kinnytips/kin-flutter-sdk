// Helper class to use the methods of
//
import 'dart:convert';
import 'dart:typed_data';
import 'dart:convert' show utf8;

import 'package:kin_sdk/codec/base_64.dart';

const MASK_MAGIC_BYTE_INDICATOR = 3;
const BIT_OFFSET_MAGIC_BYTE_INDICATOR = 0;
const MASK_VERSION = 0x1C;
const MASK_TYPE_ID = 0x3E0;
const MASK_APP_IDX = 0x3FFFC00;

const unknown = -1;
const none = 0;
const earn = 1;
const spend = 2;
const p2p = 3;

const BIT_LENGTH_MAGIC_BYTE_INDICATOR = 2;
const BIT_LENGTH_VERSION = 3;
const BIT_LENGTH_TYPE_ID = 5;
const BIT_LENGTH_APP_IDX = 16;
const BIT_LENGTH_FOREIGN_KEY = 230;

const BIT_OFFSET_VERSION = BIT_LENGTH_MAGIC_BYTE_INDICATOR;
const BIT_OFFSET_TYPE_ID = BIT_OFFSET_VERSION + BIT_LENGTH_VERSION;
const BIT_OFFSET_APP_IDX = BIT_OFFSET_TYPE_ID + BIT_LENGTH_TYPE_ID;
const BIT_OFFSET_FOREIGN_KEY = BIT_OFFSET_APP_IDX + BIT_LENGTH_APP_IDX;

Uint8List int32bytes(int value) =>
    Uint8List(4)..buffer.asInt32List()[0] = value;

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

abstract class KinHelper {
  static Uint8List getForeignKeyBytes(String foreignKey) {
    Uint8List bytes = Base64(
            lineSeparator: Uint8List.fromList([13, 10]),
            decodeTable: Uint8List.fromList(DECODE_TABLE))
        .decode(foreignKey);
    List result = bytes.sublist(0, 29);
    result[28] = result[28] & int.parse("0x3F");
    return result;
  }

  //

  static Uint8List encode() {
    const version = 0;
    const appIdx = 1;
    const magicByteIndicator = 1;
    const foreignKey = "LlGNZRHhFnMcDk3/oZ62OsPrRXjv0M2sk9YTIAA=";

    var byteCountTotal = ((BIT_LENGTH_MAGIC_BYTE_INDICATOR +
                BIT_LENGTH_VERSION +
                BIT_LENGTH_TYPE_ID +
                BIT_LENGTH_APP_IDX +
                BIT_LENGTH_FOREIGN_KEY) /
            8.0)
        .ceil()
        .toInt();
    var typeArray = List.filled(byteCountTotal, 0);

    // result = {65, 4, 0, 0}

    var lowerBytes = int32bytes((magicByteIndicator <<
            (BIT_OFFSET_MAGIC_BYTE_INDICATOR & MASK_MAGIC_BYTE_INDICATOR)) |
        (version << BIT_OFFSET_VERSION & MASK_VERSION) |
        (spend << BIT_OFFSET_TYPE_ID & MASK_TYPE_ID) |
        (appIdx << BIT_OFFSET_APP_IDX & MASK_APP_IDX));

    var byteCountLowerBytes = (((BIT_LENGTH_MAGIC_BYTE_INDICATOR +
                    BIT_LENGTH_VERSION +
                    BIT_LENGTH_TYPE_ID +
                    BIT_LENGTH_APP_IDX) /
                8.0)
            .ceil())
        .toInt();

    List.copyRange(typeArray, 0, lowerBytes, 0, byteCountLowerBytes);

    int byteOfFkStart = (BIT_OFFSET_FOREIGN_KEY / 8.0).floor().toInt();

    Uint8List foreignKeyBytes = getForeignKeyBytes(foreignKey);

    typeArray[byteOfFkStart] = typeArray[byteOfFkStart] |
        ((foreignKeyBytes[0] & int.parse("0x3F")) << 2).toSigned(8);

    // kotlin expected [46, 81, -115, 101, 17, -31, 22, 115, 28, 14, 77, -1, -95, -98, -74, 58, -61, -21, 69, 120, -17, -48, -51, -84, -109, -42, 19, 32, 0]
    // dart actual     [46, 81, 141, 101, 17, 225, 22, 115, 28, 14, 77, 255, 161, 158, 182, 58, 195, 235, 69, 120, 239, 208, 205, 172, 147, 214, 19, 32, 0]

    print("foreignKeyBytes $foreignKeyBytes");

    for (var i = byteOfFkStart + 1; i < 2 + foreignKeyBytes.length; i++) {
      typeArray[i] =
          typeArray[i] | ((foreignKeyBytes[i - 4] >> 6) & int.parse("0x3"));
      typeArray[i] = typeArray[i] |
          ((foreignKeyBytes[i - 3] & int.parse("0x3F") << 2).toSigned(8));
    }
    if (foreignKeyBytes.length < 29) {
      typeArray[byteOfFkStart + foreignKeyBytes.length] =
          ((foreignKeyBytes[foreignKeyBytes.length - 1]) >> 6) &
              int.parse("0x3");
    }
    //[65, 4, 0, -72, 68, 53, -106, 69, -124, 91, -52, 113, 56, 52, -3, -121, 122, -38, -22, 12, -81, 23, -31, -67, 67, 55, -77, 78, 90, 79, -128, 0]
    //[65, 4, 0, -72, 80, -115, 102, 17, -32, 23, 112, 29, 12, 76, -3, -93, -98, -74, 58, -64, -21, 71, 121, -19, -45, -49, -81, -110, -42, 19, 32, 0]
    print("result $typeArray");

    return Uint8List.fromList(typeArray);
  }

  void decode(Uint8List bytes){

  }
}
