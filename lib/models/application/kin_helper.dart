// Helper class to use the methods of
//
import 'dart:convert';
import 'dart:typed_data';

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

abstract class KinHelper {
  static Uint8List getForeignKeyBytes(String foreignKey) {
    Uint8List result = Base64Codec().decode(foreignKey).sublist(0, 29);
    result[28] = result[28] & int32bytes(int.parse("0x3F"))[0];
    return result;
  }

  static Uint8List encode() {
    // const lowerBytes =;
    const version = 0;
    const appIdx = 1;
    const magicByteIndicator = 1;
    const foreignKey = "LlGNZRHhFnMcDk3/oZ62OsPrRXjv0M2sk9YTIAA=";
    var typeArray = Uint8List(32);

    // result = {65, 4, 0, 0}

    var result = int32bytes((magicByteIndicator <<
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

    List.copyRange(result, 0, typeArray, 0, byteCountLowerBytes);

    int byteOfFkStart = (BIT_OFFSET_FOREIGN_KEY / 8.0).floor().toInt();

    typeArray[byteOfFkStart] = typeArray[byteOfFkStart] |
        (((getForeignKeyBytes(foreignKey)[0] & int.parse("0x3F"))) << 2);

    print("lowerBytes: $result");

    return Uint8List(20);
  }
}
