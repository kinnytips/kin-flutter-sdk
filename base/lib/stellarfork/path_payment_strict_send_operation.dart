// Copyright 2020 The Stellar Flutter SDK Authors. All rights reserved.
// Use of this source code is governed by a license that can be
// found in the LICENSE file.

import 'muxed_account.dart';

import 'operation.dart';
import 'assets.dart';

import 'util.dart';
import 'xdr/xdr_asset.dart';
import 'xdr/xdr_payment.dart';
import 'xdr/xdr_operation.dart';
import 'xdr/xdr_type.dart';

/// Represents <a href="https://developers.stellar.org/docs/start/list-of-operations/#path-payment-strict-send" target="_blank">PathPaymentStrictSend</a> operation.
/// @see <a href="https://developers.stellar.org/docs/start/list-of-operations/" target="_blank">List of Operations</a>
class PathPaymentStrictSendOperation extends Operation {
  Asset _sendAsset;
  String _sendAmount;
  MuxedAccount _destination;
  Asset _destAsset;
  String _destMin;
  late List<Asset> _path;

  PathPaymentStrictSendOperation(
      this._sendAsset,
      this._sendAmount,
      this._destination,
      this._destAsset,
      this._destMin,
      List<Asset>? path) {
    if (path == null) {
      this._path = <Asset>[];
    } else {
      checkArgument(
          path.length <= 5, "The maximum number of assets in the path is 5");
      this._path = path;
    }
  }

  /// The asset deducted from the sender's account.
  Asset get sendAsset => _sendAsset;

  /// The amount of send asset to deduct (excluding fees)
  String get sendAmount => _sendAmount;

  /// Account that receives the payment.
  MuxedAccount get destination => _destination;

  /// The asset the destination account receives.
  Asset get destAsset => _destAsset;

  /// The minimum amount of destination asset the destination account receives.
  String get destMin => _destMin;

  /// The assets (other than send asset and destination asset) involved in the offers the path takes. For example, if you can only find a path from USD to EUR through XLM and BTC, the path would be USD -&raquo; XLM -&raquo; BTC -&raquo; EUR and the path would contain XLM and BTC.
  List<Asset> get path => _path;

  @override
  XdrOperationBody toOperationBody() {
    XdrPathPaymentStrictSendOp op = XdrPathPaymentStrictSendOp();

    // sendAsset
    op.sendAsset = sendAsset.toXdr();
    // sendMax
    XdrInt64 sendMax = XdrInt64(Operation.toXdrAmount(this.sendAmount));
    op.sendMax = sendMax;
    // destination
    op.destination = this._destination.toXdr();
    // destAsset
    op.destAsset = destAsset.toXdr();
    // destAmount
    XdrInt64 destAmount = XdrInt64(Operation.toXdrAmount(this.destMin));
    op.destAmount = destAmount;
    // path

    var path = List<XdrAsset>.generate(this.path.length, (i) {
      return this.path[i].toXdr();
    });
    op.path = path;

    XdrOperationBody body = XdrOperationBody();
    body.discriminant = XdrOperationType.PATH_PAYMENT_STRICT_SEND;
    body.pathPaymentStrictSendOp = op;
    return body;
  }

  /// Builds PathPayment operation.
  static PathPaymentStrictSendOperationBuilder builder(
      XdrPathPaymentStrictSendOp op) {
    var path = List<Asset>.generate(op.path!.length, (i) {
      return Asset.fromXdr(op.path![i]);
    });

    return PathPaymentStrictSendOperationBuilder.forMuxedDestinationAccount(
            Asset.fromXdr(op.sendAsset!),
            Operation.fromXdrAmount(op.sendMax!.int64),
            MuxedAccount.fromXdr(op.destination!),
            Asset.fromXdr(op.destAsset!),
            Operation.fromXdrAmount(op.destAmount!.int64))
        .setPath(path);
  }
}

class PathPaymentStrictSendOperationBuilder {
  Asset _sendAsset;
  String _sendAmount;
  MuxedAccount _destination;
  Asset _destAsset;
  String _destMin;
  List<Asset>? _path;
  MuxedAccount? _mSourceAccount;

  /// Creates a PathPaymentStrictSendOperation builder.
  PathPaymentStrictSendOperationBuilder(this._sendAsset, this._sendAmount,
      String destination, this._destAsset, this._destMin) :
        this._destination = MuxedAccount(destination, null);

  /// Creates a PathPaymentStrictSendOperation builder for a MuxedAccount as a destination.
  PathPaymentStrictSendOperationBuilder.forMuxedDestinationAccount(
      this._sendAsset,
      this._sendAmount,
      this._destination,
      this._destAsset,
      this._destMin) ;

  /// Sets path for this operation
  PathPaymentStrictSendOperationBuilder setPath(List<Asset> path) {
    checkArgument(
        path.length <= 5, "The maximum number of assets in the path is 5");
    this._path = path;
    return this;
  }

  /// Sets the source account for this operation.
  PathPaymentStrictSendOperationBuilder setSourceAccount(String sourceAccount) {
    _mSourceAccount = MuxedAccount(sourceAccount, null);
    return this;
  }

  /// Sets the muxed source account for this operation.
  PathPaymentStrictSendOperationBuilder setMuxedSourceAccount(
      MuxedAccount sourceAccount) {
    _mSourceAccount = sourceAccount;
    return this;
  }

  /// Builds a PathPaymentStrictSendOperation.
  PathPaymentStrictSendOperation build() {
    PathPaymentStrictSendOperation operation = PathPaymentStrictSendOperation(
        _sendAsset, _sendAmount, _destination, _destAsset, _destMin, _path);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount!;
    }
    return operation;
  }
}
