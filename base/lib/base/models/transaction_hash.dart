import 'dart:typed_data';

import 'package:kin_base/base/tools/extensions.dart';
import 'package:kin_base/base/tools/hex.dart';

class TransactionHash {
  final Uint8List rawValue;

  TransactionHash(this.rawValue);

  TransactionHash.fromHashString(String transactionHashString)
      : this(HexDecoder().convert(transactionHashString));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionHash &&
          runtimeType == other.runtimeType &&
          rawValue.equalsContent(other.rawValue);

  @override
  int get hashCode => rawValue.computeHashCode();

  @override
  String toString() => HexEncoder().convert(rawValue);
}
