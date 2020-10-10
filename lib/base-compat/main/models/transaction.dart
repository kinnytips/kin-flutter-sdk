import 'key_pair.dart';

class Transaction {
  KeyPair source;
  KeyPair destination;

    Uint8List hash(Network network) {
    return Util.hash(this.signatureBase(network));
  }

  Uint8List signatureBase(Network network);
}