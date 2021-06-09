///
//  Generated code. Do not modify.
//  source: transaction/v3/transaction_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transaction_service.pb.dart' as $1;
export 'transaction_service.pb.dart';

class TransactionClient extends $grpc.Client {
  static final _$getHistory =
      $grpc.ClientMethod<$1.GetHistoryRequest, $1.GetHistoryResponse>(
          '/kin.agora.transaction.v3.Transaction/GetHistory',
          ($1.GetHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetHistoryResponse.fromBuffer(value));
  static final _$submitTransaction = $grpc.ClientMethod<
          $1.SubmitTransactionRequest, $1.SubmitTransactionResponse>(
      '/kin.agora.transaction.v3.Transaction/SubmitTransaction',
      ($1.SubmitTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.SubmitTransactionResponse.fromBuffer(value));
  static final _$getTransaction =
      $grpc.ClientMethod<$1.GetTransactionRequest, $1.GetTransactionResponse>(
          '/kin.agora.transaction.v3.Transaction/GetTransaction',
          ($1.GetTransactionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetTransactionResponse.fromBuffer(value));

  TransactionClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.GetHistoryResponse> getHistory(
      $1.GetHistoryRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getHistory, request, options: options);
  }

  $grpc.ResponseFuture<$1.SubmitTransactionResponse> submitTransaction(
      $1.SubmitTransactionRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$submitTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetTransactionResponse> getTransaction(
      $1.GetTransactionRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getTransaction, request, options: options);
  }
}

abstract class TransactionServiceBase extends $grpc.Service {
  $core.String get $name => 'kin.agora.transaction.v3.Transaction';

  TransactionServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.GetHistoryRequest, $1.GetHistoryResponse>(
        'GetHistory',
        getHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetHistoryRequest.fromBuffer(value),
        ($1.GetHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SubmitTransactionRequest,
            $1.SubmitTransactionResponse>(
        'SubmitTransaction',
        submitTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SubmitTransactionRequest.fromBuffer(value),
        ($1.SubmitTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetTransactionRequest,
            $1.GetTransactionResponse>(
        'GetTransaction',
        getTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetTransactionRequest.fromBuffer(value),
        ($1.GetTransactionResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.GetHistoryResponse> getHistory_Pre($grpc.ServiceCall call,
      $async.Future<$1.GetHistoryRequest> request) async {
    return getHistory(call, await request);
  }

  $async.Future<$1.SubmitTransactionResponse> submitTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SubmitTransactionRequest> request) async {
    return submitTransaction(call, await request);
  }

  $async.Future<$1.GetTransactionResponse> getTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetTransactionRequest> request) async {
    return getTransaction(call, await request);
  }

  $async.Future<$1.GetHistoryResponse> getHistory(
      $grpc.ServiceCall call, $1.GetHistoryRequest request);
  $async.Future<$1.SubmitTransactionResponse> submitTransaction(
      $grpc.ServiceCall call, $1.SubmitTransactionRequest request);
  $async.Future<$1.GetTransactionResponse> getTransaction(
      $grpc.ServiceCall call, $1.GetTransactionRequest request);
}
