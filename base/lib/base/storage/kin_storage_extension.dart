import 'dart:typed_data';

import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/kin_transactions.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/stellar/models/record_type.dart';
import 'package:kin_base/stellarfork/xdr/xdr_data_io.dart';
import 'package:kin_base/stellarfork/xdr/xdr_transaction.dart';
import 'package:kin_base_storage/kin_base_storage.dart' as base_storage;
import 'package:protobuf/protobuf.dart';

import 'package:kin_base/base/tools/extensions.dart';

import 'package:kin_base/base/network/api/agora/model_to_proto.dart';

extension KinAccountExtension on KinAccount {
  base_storage.KinAccount toStorageKinAccount() {
    var storageKinAccount = base_storage.KinAccount.create()
      ..balance = this.balance.toStorageKinBalance();

    var status = this.status;
    if (status is KinAccountStatusUnregistered) {
      storageKinAccount.status = base_storage.KinAccount_Status.UNREGISTERED;
    } else if (status is KinAccountStatusRegistered) {
      storageKinAccount
        ..status = base_storage.KinAccount_Status.REGISTERED
        ..sequenceNumber = fixnum.Int64(status.sequence);
    }

    var key = this.key;

    if (key is PublicKey) {
      var publicKey = base_storage.PublicKey.create()..value = key.value!;
      storageKinAccount.publicKey = publicKey;
    } else if (key is PrivateKey) {
      var privateKey = base_storage.PrivateKey.create()..value = key.value!;
      storageKinAccount.privateKey = privateKey;
    }

    storageKinAccount.accounts.addAll(this.tokenAccounts.map((e) {
      return base_storage.PublicKey.create()..value = e.value!;
    }));

    return storageKinAccount;
  }
}

extension KinBalanceExtension on KinBalance {
  base_storage.KinBalance toStorageKinBalance() {
    return base_storage.KinBalance.create()
      ..quarkAmount = fixnum.Int64(this.amount.toQuarks().value!)
      ..pendingQuarkAmount = fixnum.Int64(this.pendingAmount.toQuarks().value!);
  }
}

extension InvoiceListMapExtension on Map<InvoiceListId,InvoiceList?> {

  base_storage.Invoices toInvoices() {
    var invoices = base_storage.Invoices() ;
    for (var entry in this.entries) {
      var blob = base_storage.InvoiceListBlob(networkInvoiceList: entry.value!.toProto().writeToBuffer());
      invoices.invoiceLists[ entry.key.invoiceHash.encodedValue ] = blob ;
    }
    return invoices ;
  }

}

extension StorageKinAccountExtension on base_storage.KinAccount {
  KinAccount toKinAccount() {
    Key key;
    if (this.hasPrivateKey()) {
      key = this.privateKey.toPrivateKey();
    } else if (this.hasPublicKey()) {
      key = this.publicKey.toPublicKey();
    } else {
      throw InvalidProtocolBufferException.truncatedMessage();
    }

    var balance = this.balance.toKinBalance();

    var sequence = this.sequenceNumber.toInt();

    KinAccountStatus status;
    if (this.status.value ==
        base_storage.KinAccount_Status.REGISTERED.value) {
      status = KinAccountStatusRegistered(sequence);
    } else if (this.status.value ==
        base_storage.KinAccount_Status.UNREGISTERED.value) {
      status = KinAccountStatusUnregistered.instance;
    } else {
      throw InvalidProtocolBufferException.truncatedMessage();
    }

    var accounts = <PublicKey>[];
    if (this.accounts.isNotEmpty) {
      accounts.addAll(this.accounts.map((e) => e.toPublicKey()));
    }

    return KinAccount(key,
        tokenAccounts: accounts, balance: balance, status: status);
  }
}

extension StorageKinBalanceExtension on base_storage.KinBalance {
  KinBalance toKinBalance() {
    var amount = QuarkAmount(this.quarkAmount.toInt()).toKin();
    var pendingAmount = QuarkAmount(this.pendingQuarkAmount.toInt()).toKin();
    return KinBalance(amount, pendingAmount);
  }
}

extension StoragePublicKeyExtension on base_storage.PublicKey {
  PublicKey toPublicKey() => PublicKey.fromBytes(this.value as Uint8List?);
}

extension StoragePrivateKeyExtension on base_storage.PrivateKey {
  PrivateKey toPrivateKey() => PrivateKey.fromBytes(this.value as Uint8List);
}

extension StorageKinTransactionsExtension on base_storage.KinTransactions {

  KinTransactions toKinTransactions(NetworkEnvironment? networkEnvironment) {
    return KinTransactions(
      this.items.map( (e) => e.toKinTransaction(networkEnvironment) ) as List<KinTransaction> ,
        PagingToken(headPagingToken),
        PagingToken(tailPagingToken)
    );
  }

}

extension StorageKinTransactionExtension on base_storage.KinTransaction {

  KinTransaction toKinTransaction(NetworkEnvironment? networkEnvironment) {
    RecordType? recordType ;
    if (this.status.value == base_storage.KinTransaction_Status.INFLIGHT.value ) {
      recordType = RecordType( this.timestamp.toInt() ) ;
    }
    else if (this.status.value == base_storage.KinTransaction_Status.ACKNOWLEDGED.value ) {
      recordType = RecordTypeAcknowledged(this.timestamp.toInt() , this.resultXdr.toUint8List());
    }
    else if (this.status.value == base_storage.KinTransaction_Status.HISTORICAL.value ) {
      recordType = RecordTypeHistorical(this.timestamp.toInt() , this.resultXdr.toUint8List(), PagingToken(this.pagingToken) );
    }

    try {
      XdrTransactionEnvelope.decode(XdrDataInputStream(this.envelopeXdr.toUint8List()));
      throw UnsupportedError('StellarKinTransaction not supported yet!');
    }
    on UnsupportedError {
      rethrow ;
    }
    catch (e) {
      return SolanaKinTransaction(this.envelopeXdr.toUint8List(),  recordType,  networkEnvironment);
    }
  }

}
