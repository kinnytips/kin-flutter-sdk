import 'dart:typed_data';

import 'package:kin_base/base/tools/base58.dart';
import 'package:kin_base/base/tools/extensions.dart';
import 'package:kin_base/base/tools/hex.dart';

class TransactionHash {
  final Uint8List rawValue;

  TransactionHash(this.rawValue);

  TransactionHash.fromHashString(String transactionHashString)
      : this(HexDecoder().convert(transactionHashString));

  String toBase58() => Base58().encode(this.rawValue);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionHash &&
          runtimeType == other.runtimeType &&
          rawValue.equalsContent(other.rawValue);

  @override
  int get hashCode => rawValue.computeHashCode();

  @override
  String toString() { 
    return "Id(value=${HexEncoder().convert(rawValue)}, b58=${toBase58()})";
  }
}
