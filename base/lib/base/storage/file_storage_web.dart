import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'file_storage.dart';

class FileStorageWeb extends FileStorage {
  bool writeToFile(String directory, String fileName, Uint8List body) {
    var filePath = _joinPath(directory, fileName);

    var dataBae64 = Base64Codec().encode(body);

    _setKey(filePath, dataBae64);

    return true;
  }

  bool removeFile(String directory, String fileName) {
    var filePath = _joinPath(directory, fileName);

    var dataBae64 = _removeKey(filePath);
    return dataBae64 != null;
  }

  Uint8List readFile(String directory, String fileName) {
    var filePath = _joinPath(directory, fileName);

    var dataBae64 = _getKey(filePath);

    if (dataBae64 == null || dataBae64.isEmpty) return Uint8List(0);

    return Base64Codec().decode(dataBae64);
  }

  List<String> subdirectories(String directory) {
    var basePath = '$directory/';

    var directories =
        window.localStorage.keys.where((k) => k.startsWith(basePath)).toSet();

    if (directories.isEmpty) return <String>[];

    var subDirs = directories.toList();

    return subDirs;
  }

  String _joinPath(String directory, String fileName) => '$directory/$fileName';

  void _setKey(String key, String value) => window.localStorage[key] = value;

  String _getKey(String key) => window.localStorage[key];

  String _removeKey(String key) => window.localStorage.remove(key);
}

FileStorage createFileStorage() => FileStorageWeb();
