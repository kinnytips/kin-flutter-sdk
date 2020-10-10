///
//  Generated code. Do not modify.
//  source: transaction/v3/transaction_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'transaction_service.pb.dart' as $3;
import 'transaction_service.pbjson.dart';

export 'transaction_service.pb.dart';

abstract class TransactionServiceBase extends $pb.GeneratedService {
  $async.Future<$3.GetHistoryResponse> getHistory($pb.ServerContext ctx, $3.GetHistoryRequest request);
  $async.Future<$3.SubmitTransactionResponse> submitTransaction($pb.ServerContext ctx, $3.SubmitTransactionRequest request);
  $async.Future<$3.GetTransactionResponse> getTransaction($pb.ServerContext ctx, $3.GetTransactionRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'GetHistory': return $3.GetHistoryRequest();
      case 'SubmitTransaction': return $3.SubmitTransactionRequest();
      case 'GetTransaction': return $3.GetTransactionRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'GetHistory': return this.getHistory(ctx, request);
      case 'SubmitTransaction': return this.submitTransaction(ctx, request);
      case 'GetTransaction': return this.getTransaction(ctx, request);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => TransactionServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => TransactionServiceBase$messageJson;
}

