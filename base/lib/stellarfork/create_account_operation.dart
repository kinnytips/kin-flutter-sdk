// Copyright 2020 The Stellar Flutter SDK Authors. All rights reserved.
// Use of this source code is governed by a license that can be
// found in the LICENSE file.

import 'muxed_account.dart';

import 'operation.dart';
import 'key_pair.dart';
import 'xdr/xdr_operation.dart';
import 'xdr/xdr_account.dart';
import 'xdr/xdr_type.dart';

/// Represents <a href="https://developers.stellar.org/docs/start/list-of-operations/#create-account" target="_blank">CreateAccount</a> operation.
/// See: @see <a href="https://developers.stellar.org/docs/start/list-of-operations/" target="_blank">List of Operations</a>
class CreateAccountOperation extends Operation {
  String _destination;
  String _startingBalance;

  CreateAccountOperation(this._destination, this._startingBalance) ;

  /// Amount of XLM to send to the newly created account.
  String get startingBalance => _startingBalance;

  /// Account that is created and funded.
  String get destination => _destination;

  @override
  XdrOperationBody toOperationBody() {
    XdrCreateAccountOp op = XdrCreateAccountOp();
    XdrAccountID destination = XdrAccountID();
    destination.accountID =
        KeyPair.fromAccountId(this.destination).xdrPublicKey;
    op.destination = destination;
    op.startingBalance = XdrInt64(Operation.toXdrAmount(this.startingBalance));

    XdrOperationBody body = XdrOperationBody();
    body.discriminant = XdrOperationType.CREATE_ACCOUNT;
    body.createAccountOp = op;
    return body;
  }

  /// Builds CreateAccount operation.
  static CreateAccountOperationBuilder builder(XdrCreateAccountOp op) {
    return CreateAccountOperationBuilder(
        KeyPair.fromXdrPublicKey(op.destination!.accountID!).accountId,
        Operation.fromXdrAmount(op.startingBalance!.int64.toInt()));
  }
}

class CreateAccountOperationBuilder {
  String _destination;
  String _startingBalance;
  MuxedAccount? _mSourceAccount;

  /// Creates a CreateAccount builder.
  CreateAccountOperationBuilder(this._destination, this._startingBalance);

  /// Sets the source account for this operation represented by [sourceAccount].
  CreateAccountOperationBuilder setSourceAccount(String sourceAccount) {
    _mSourceAccount = MuxedAccount(sourceAccount, null);
    return this;
  }

  /// Sets the muxed source account for this operation represented by [sourceAccountId].
  CreateAccountOperationBuilder setMuxedSourceAccount(
      MuxedAccount sourceAccount) {
    _mSourceAccount = sourceAccount;
    return this;
  }

  ///Builds an operation
  CreateAccountOperation build() {
    CreateAccountOperation operation =
        CreateAccountOperation(_destination, _startingBalance);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount!;
    }
    return operation;
  }
}
