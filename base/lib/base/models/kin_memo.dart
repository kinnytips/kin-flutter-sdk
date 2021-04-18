import 'dart:typed_data';

import 'package:kin_base/base/tools/charsets.dart';
import 'package:kin_base/base/tools/extensions.dart';

import 'kin_binary_memo.dart';

class KinMemoType {
  final int value;

  KinMemoType(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KinMemoType &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class KinMemoTypeNoEncoding extends KinMemoType {
  static final KinMemoTypeNoEncoding _instance = KinMemoTypeNoEncoding._();

  KinMemoTypeNoEncoding._() : super(0);

  factory KinMemoTypeNoEncoding() => _instance;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is KinMemoTypeNoEncoding &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;
}

class KinMemoTypeCharsetEncoded extends KinMemoType {
  final Charset charset;

  KinMemoTypeCharsetEncoded(this.charset) : super(1);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is KinMemoTypeCharsetEncoded &&
          runtimeType == other.runtimeType &&
          charset == other.charset;

  @override
  int get hashCode => super.hashCode ^ charset.hashCode;
}

class KinMemo {
  static final KinMemo none = KinMemo(Uint8List(0), KinMemoTypeNoEncoding());

  final Uint8List rawValue;

  final KinMemoType type;

  KinMemo(this.rawValue, [KinMemoType type])
      : type = type ?? KinMemoTypeNoEncoding();

  factory KinMemo.fromText(String text, [Charset charset]) {
    charset ??= Charset.utf8;
    var bytes = charset.encode(text);
    return KinMemo(bytes, KinMemoTypeCharsetEncoded(charset));
  }

  KinBinaryMemo getAgoraMemo() {
    try {
      // TODO:
      // KinBinaryMemo.decode(rawValue) ;
    } on Error {
      return null;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KinMemo &&
          runtimeType == other.runtimeType &&
          rawValue.equalsContent(other.rawValue) &&
          type == other.type;

  @override
  int get hashCode => rawValue.hashCode ^ type.hashCode;

  @override
  String toString() {
    var type = this.type;
    if (type is KinMemoTypeNoEncoding) {
      return rawValue.toString();
    } else if (type is KinMemoTypeCharsetEncoded) {
      return type.charset.decode(rawValue);
    } else {
      throw UnsupportedError("$type");
    }
  }
}
