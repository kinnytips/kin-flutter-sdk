import 'dart:typed_data';

extension Uint8ListExtension on Uint8List {
  Uint8List read(int numBytes) {
    var i = 0;
    Uint8List bytesList = Uint8List(numBytes);
    bytesList.forEach((element) {
      while (i < numBytes) {
        // todo: calling read from java.io.ByteArrayInputStream
        this[i++] = read();
      }
    });

    return bytesList;
  }

  Uint8List readRemainingBytes() {
    var i = 0;
    // todo: calling available from java.io.ByteArrayInputStream
    Uint8List bytesList = Uint8List(available());
    bytesList.forEach((element) {
      while (available() != 0) {
        this[i++] = read();
      }
    });

    return bytesList;
  }

  toModel(Function newInstance) {
    newInstance(this) ??
        // todo: how to do this in dart?
        T::class.java.getConstructor(ByteArray::class.java).newInstance(this);
  }
}

wrapError<T>(String msg, Function wrapped) {
  T value;
  try {
    value = wrapped();
  } catch (e) {
    throw Exception(msg);
  }
  return value;
}
