import 'dart:typed_data';

import 'paging_token.dart';

class RecordType {
  int value ;
  int timestamp;

  RecordType(this.value, {this.timestamp});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordType &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          timestamp == other.timestamp;

  @override
  int get hashCode => value.hashCode ^ timestamp.hashCode;
}

class RecordTypeInflight extends RecordType {
  static const defaultValue = 0 ;

  RecordTypeInflight(int timestamp) : super(defaultValue, timestamp: timestamp);
}

class RecordTypeAcknowledged extends RecordType {
  static const defaultValue = 1 ;

  final Uint8List resultXdrBytes ;

  RecordTypeAcknowledged(int timestamp, this.resultXdrBytes) : super(defaultValue, timestamp: timestamp);
}

class RecordTypeHistorical extends RecordType {
  static const defaultValue = 2 ;

  final Uint8List resultXdrBytes ;
  final PagingToken pagingToken;

  RecordTypeHistorical(int timestamp, this.resultXdrBytes, this.pagingToken) : super(defaultValue, timestamp: timestamp);
}

class ResultCodeParser {
  Uint8List resultXdrBytes;

  ResultCodeParser(this.resultXdrBytes);

  void parseResultCode() {
    // TODO Add StellarFork.TransactionResult and the parser
    throw UnsupportedError('todo');
  }
}
