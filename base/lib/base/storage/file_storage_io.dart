import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;

import 'file_storage.dart';

class FileStorageIO extends FileStorage {
  bool writeToFile(String directory, String fileName, Uint8List body) {
    var file = File(path.join(directory, fileName));

    var parent = file.parent;
    if (!parent.existsSync()) {
      parent.createSync(recursive: true);
    }

    file.writeAsBytesSync(body);

    return true;
  }

  bool removeFile(String directory, String fileName) {
    var file = File(path.join(directory, fileName));

    if (!file.existsSync()) return true;

    file.deleteSync();

    return true;
  }

  Uint8List readFile(String directory, String fileName) {
    var file = File(path.join(directory, fileName));

    if (!file.existsSync()) return Uint8List(0);

    return file.readAsBytesSync();
  }

  List<String> subdirectories(String directory) {
    var dir = Directory(directory);

    if (!dir.existsSync()) return <String>[];

    var subDirs = dir.listSync().map((e) => e.path).toList();

    return subDirs;
  }
}

FileStorage createFileStorage() => FileStorageIO();
