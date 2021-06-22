import 'dart:typed_data';

import 'file_storage.dart';

class FileStorageGeneric extends FileStorage {
  bool writeToFile(String directory, String fileName, Uint8List body) {
    return false;
  }

  bool removeFile(String directory, String fileName) {
    return false;
  }

  Uint8List readFile(String directory, String fileName) {
    return Uint8List(0);
  }

  List<String> subdirectories(String directory) {
    return <String>[];
  }
}

FileStorage createFileStorage() => FileStorageGeneric();
