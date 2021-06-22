import 'dart:typed_data';

import 'file_storage_generic.dart'
    if (dart.library.io) "file_storage_io.dart"
    if (dart.library.html) "file_storage_html.dart";

abstract class FileStorage {
  static FileStorage create() => createFileStorage();

  bool writeToFile(String directory, String fileName, Uint8List body);

  bool removeFile(String directory, String fileName);

  Uint8List readFile(String directory, String fileName);

  List<String> subdirectories(String directory);
}
