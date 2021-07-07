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

  KinAccountId.fromPrivateKey(PrivateKey privateKey) : this.fromPublicKey(privateKey.asPublicKey());

  KinAccountId.fromPublicKey(PublicKey publicKey) : this(publicKey.value);

  factory KinAccountId.from(dynamic o) {
    if (o is KinAccountId) return o ;
    if (o is PrivateKey) return KinAccountId.fromPrivateKey(o) ;
    if (o is PublicKey) return KinAccountId.fromPublicKey(o) ;
    if (o is String) return KinAccountId.fromIdString(o) ;
    throw StateError("Can't resolve: $o");
  }

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

  static final int defaultValue = 0 ;

  KinAccountStatusUnregistered._() : super._(defaultValue);

  factory KinAccountStatusUnregistered() => instance;
}

class KinAccountStatusRegistered extends KinAccountStatus {
  static final int defaultValue = 1 ;

  int sequence;

  KinAccountStatusRegistered(this.sequence) : super._(defaultValue);
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

  KinAccount copy({Key key , KinAccountId id , List<PublicKey> tokenAccounts,
    KinBalance balance,
    KinAccountStatus status
  }) {
    key ??= this.key ;
    id ??= this.id ;
    tokenAccounts ??= this.tokenAccounts ;
    balance ??= this.balance;
    status ??= this.status;
    return KinAccount(key, id: id, tokenAccounts: tokenAccounts, balance: balance, status: status);
  }

  KinAccount merge(KinAccount newer) {
    return KinAccount(key, id: id, tokenAccounts: newer.tokenAccounts, balance: newer.balance, status: newer.status);
  }

  @override
  String toString() {
    return 'KinAccount{key: $key, id: $id, tokenAccounts: $tokenAccounts, balance: $balance, status: $status}';
  }
}
