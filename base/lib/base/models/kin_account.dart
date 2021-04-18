import 'dart:typed_data';

import 'package:kin_base/base/tools/base58.dart';
import 'package:kin_base/base/tools/extensions.dart';
import 'package:kin_base/stellarfork/key_pair.dart';

import 'key.dart';
import 'kin_balance.dart';

class KinAccountId {
  final Uint8List value;

  KinAccountId(this.value);

  KinAccountId.fromIdString(String accountId)
      : this(KeyPair.fromAccountId(accountId).publicKey);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KinAccountId &&
          runtimeType == other.runtimeType &&
          value.equalsContent(other.value);

  @override
  int get hashCode => value.computeHashCode();

  String toString() {
    return "Id(value=${stellarBase32Encode()}, b58=${base58Encode()})";
  }

  String stellarBase32Encode() => toKeyPair().accountId;

  String base58Encode() => Base58().encode(value);

  KeyPair toKeyPair() => KeyPair.fromPublicKey(value);
}

class KinAccountStatus {
  final int value;

  KinAccountStatus._(this.value);
}

class KinAccountStatusUnregistered extends KinAccountStatus {
  static final KinAccountStatusUnregistered instance =
      KinAccountStatusUnregistered._();

  KinAccountStatusUnregistered._() : super._(0);

  factory KinAccountStatusUnregistered() => instance;
}

class KinAccountStatusRegistered extends KinAccountStatus {
  int sequence;

  KinAccountStatusRegistered(this.sequence) : super._(1);
}

class KinAccount {
  final Key key;
  final KinAccountId id;
  final List<PublicKey> tokenAccounts;
  final KinBalance balance;
  final KinAccountStatus status;

  KinAccount(this.key,
      {KinAccountId id,
      List<PublicKey> tokenAccounts,
      KinBalance balance,
      KinAccountStatus status})
      : id = id ?? KinAccountId(key.asPublicKey().value),
        tokenAccounts = tokenAccounts ?? <PublicKey>[],
        balance = balance ?? KinBalance(),
        status = status ?? KinAccountStatusUnregistered();
}
