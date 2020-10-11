///
//  Generated code. Do not modify.
//  source: transaction/v3/transaction_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transaction_service.pb.dart' as $0;
export 'transaction_service.pb.dart';

class TransactionClient extends $grpc.Client {
  static final _$getHistory =
      $grpc.ClientMethod<$0.GetHistoryRequest, $0.GetHistoryResponse>(
          '/kin.agora.transaction.v3.Transaction/GetHistory',
          ($0.GetHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetHistoryResponse.fromBuffer(value));
  static final _$submitTransaction = $grpc.ClientMethod<
          $0.SubmitTransactionRequest, $0.SubmitTransactionResponse>(
      '/kin.agora.transaction.v3.Transaction/SubmitTransaction',
      ($0.SubmitTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SubmitTransactionResponse.fromBuffer(value));
  static final _$getTransaction =
      $grpc.ClientMethod<$0.GetTransactionRequest, $0.GetTransactionResponse>(
          '/kin.agora.transaction.v3.Transaction/GetTransaction',
          ($0.GetTransactionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetTransactionResponse.fromBuffer(value));

  TransactionClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.GetHistoryResponse> getHistory(
      $0.GetHistoryRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getHistory, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.SubmitTransactionResponse> submitTransaction(
      $0.SubmitTransactionRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$submitTransaction, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.GetTransactionResponse> getTransaction(
      $0.GetTransactionRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getTransaction, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class TransactionServiceBase extends $grpc.Service {
  $core.String get $name => 'kin.agora.transaction.v3.Transaction';

  TransactionServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetHistoryRequest, $0.GetHistoryResponse>(
        'GetHistory',
        getHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetHistoryRequest.fromBuffer(value),
        ($0.GetHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubmitTransactionRequest,
            $0.SubmitTransactionResponse>(
        'SubmitTransaction',
        submitTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SubmitTransactionRequest.fromBuffer(value),
        ($0.SubmitTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransactionRequest,
            $0.GetTransactionResponse>(
        'GetTransaction',
        getTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransactionRequest.fromBuffer(value),
        ($0.GetTransactionResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetHistoryResponse> getHistory_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetHistoryRequest> request) async {
    return getHistory(call, await request);
  }

  $async.Future<$0.SubmitTransactionResponse> submitTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SubmitTransactionRequest> request) async {
    return submitTransaction(call, await request);
  }

  $async.Future<$0.GetTransactionResponse> getTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTransactionRequest> request) async {
    return getTransaction(call, await request);
  }

  $async.Future<$0.GetHistoryResponse> getHistory(
      $grpc.ServiceCall call, $0.GetHistoryRequest request);
  $async.Future<$0.SubmitTransactionResponse> submitTransaction(
      $grpc.ServiceCall call, $0.SubmitTransactionRequest request);
  $async.Future<$0.GetTransactionResponse> getTransaction(
      $grpc.ServiceCall call, $0.GetTransactionRequest request);
}
