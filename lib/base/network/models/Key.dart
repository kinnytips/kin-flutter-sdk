import 'package:meta/meta.dart';

@sealed
class Key {

  class PublicKey constructor(override val value: ByteArray) : Key() {

  }
}
