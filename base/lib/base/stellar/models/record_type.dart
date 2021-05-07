import 'dart:typed_data';

class RecordType {
  int timeStamp;

  RecordType(this.timeStamp);
}

class Inflight extends RecordType {
  Inflight() : super(0);
}

class Acknowledged extends RecordType {
  Acknowledged() : super(1);
}

class ResultCodeParser {
  Uint8List resultXdrBytes;

  ResultCodeParser(this.resultXdrBytes);

  void parseResultCode() {
    // TODO Add StellarFork.TransactionResult and the parser
  }
}
