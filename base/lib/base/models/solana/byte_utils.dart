import 'dart:typed_data';

extension Uint8ListExtension on Uint8List {
  // A Uint8List is a fixed-length (immutable) array of bytes, and can't
  // represent a `ByteArrayInputStream`
  // The class `ByteInputBuffer` does what a `ByteArrayInputStream` should do.
  //Uint8List read(int numBytes) ;

  // The class `ByteInputBuffer` does what a `ByteArrayInputStream` should do.
  //Uint8List readRemainingBytes() ;

  T toModel<T>(T Function(Uint8List) newInstance) {
    return newInstance(this) ?? Uint8List.fromList(this) ;
        // The Kotlin code was creating a ByteArray with bytes from this.
        // In Dart is an Uint8List.
        //T::class.java.getConstructor(ByteArray::class.java).newInstance(this);
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
