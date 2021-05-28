// Copyright 2020 The Stellar Flutter SDK Authors. All rights reserved.
// Use of this source code is governed by a license that can be
// found in the LICENSE file.

import 'muxed_account.dart';

import 'operation.dart';
import 'assets.dart';
import 'price.dart';
import 'util.dart';
import 'xdr/xdr_offer.dart';
import 'xdr/xdr_operation.dart';
import 'xdr/xdr_type.dart';

/// Represents <a href="https://developers.stellar.org/docs/start/list-of-operations/#manage-sell-offer" target="_blank">ManageSellOffer</a> operation.
/// See: <a href="https://developers.stellar.org/docs/start/list-of-operations/" target="_blank">List of Operations</a>
class ManageSellOfferOperation extends Operation {
  Asset _selling;
  Asset _buying;
  String _amount;
  String _price;
  String _offerId;

  ManageSellOfferOperation(Asset selling, Asset buying, String amount,
      String price, String offerId) {
    this._selling = checkNotNull(selling, "selling cannot be null");
    this._buying = checkNotNull(buying, "buying cannot be null");
    this._amount = checkNotNull(amount, "amount cannot be null");
    this._price = checkNotNull(price, "price cannot be null");
    this._offerId = offerId;
  }

  /// The asset being sold in this operation.
  Asset get selling => _selling;

  /// The asset being bought in this operation.
  Asset get buying => _buying;

  /// Amount of selling being sold.
  String get amount => _amount;

  /// Price of 1 unit of selling in terms of buying.
  String get price => _price;

  /// The ID of the offer.
  String get offerId => _offerId;

  @override
  XdrOperationBody toOperationBody() {
    XdrManageSellOfferOp op = new XdrManageSellOfferOp();
    op.selling = selling.toXdr();
    op.buying = buying.toXdr();
    XdrInt64 amount = new XdrInt64();
    amount.int64 = Operation.toXdrAmount(this.amount);
    op.amount = amount;
    Price price = Price.fromString(this.price);
    op.price = price.toXdr();
    XdrUint64 offerId = new XdrUint64();
    offerId.uint64 = int.parse(this.offerId);
    op.offerID = offerId;

    XdrOperationBody body = new XdrOperationBody();
    body.discriminant = XdrOperationType.MANAGE_SELL_OFFER;
    body.manageSellOfferOp = op;

    return body;
  }

  /// Construct a new CreateAccount builder from a CreateAccountOp XDR.
  static ManageSellOfferOperationBuilder builder(XdrManageSellOfferOp op) {
    int n = op.price.n.int32.toInt();
    int d = op.price.d.int32.toInt();

    return ManageSellOfferOperationBuilder(
      Asset.fromXdr(op.selling),
      Asset.fromXdr(op.buying),
      Operation.fromXdrAmount(op.amount.int64.toInt()),
      removeTailZero((BigInt.from(n) / BigInt.from(d)).toString()),
    ).setOfferId(op.offerID.uint64.toInt().toString());
  }
}

class ManageSellOfferOperationBuilder {
  Asset _selling;
  Asset _buying;
  String _amount;
  String _price;
  String _offerId = "0";
  MuxedAccount _mSourceAccount;

  /// Creates a new ManageSellOfferOperation builder. If you want to update existing offer use
  ManageSellOfferOperationBuilder(
      Asset selling, Asset buying, String amount, String price) {
    this._selling = checkNotNull(selling, "selling cannot be null");
    this._buying = checkNotNull(buying, "buying cannot be null");
    this._amount = checkNotNull(amount, "amount cannot be null");
    this._price = checkNotNull(price, "price cannot be null");
  }

  /// Sets offer ID. <code>0</code> creates a new offer. Set to existing offer ID to change it.
  ManageSellOfferOperationBuilder setOfferId(String offerId) {
    this._offerId = offerId;
    return this;
  }

  /// Sets the source account for this operation.
  ManageSellOfferOperationBuilder setSourceAccount(String sourceAccount) {
    checkNotNull(sourceAccount, "sourceAccount cannot be null");
    _mSourceAccount = MuxedAccount(sourceAccount, null);
    return this;
  }

  /// Sets the muxed source account for this operation.
  ManageSellOfferOperationBuilder setMuxedSourceAccount(
      MuxedAccount sourceAccount) {
    _mSourceAccount =
        checkNotNull(sourceAccount, "sourceAccount cannot be null");
    return this;
  }

  /// Builds a ManageSellOfferOperation.
  ManageSellOfferOperation build() {
    ManageSellOfferOperation operation = new ManageSellOfferOperation(
        _selling, _buying, _amount, _price, _offerId);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount;
    }
    return operation;
  }
}
