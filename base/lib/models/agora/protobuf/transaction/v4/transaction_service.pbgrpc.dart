///
//  Generated code. Do not modify.
//  source: transaction/v4/transaction_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transaction_service.pb.dart' as $0;
export 'transaction_service.pb.dart';

class TransactionClient extends $grpc.Client {
  static final _$getServiceConfig = $grpc.ClientMethod<
          $0.GetServiceConfigRequest, $0.GetServiceConfigResponse>(
      '/kin.agora.transaction.v4.Transaction/GetServiceConfig',
      ($0.GetServiceConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetServiceConfigResponse.fromBuffer(value));
  static final _$getMinimumKinVersion = $grpc.ClientMethod<
          $0.GetMinimumKinVersionRequest, $0.GetMinimumKinVersionResponse>(
      '/kin.agora.transaction.v4.Transaction/GetMinimumKinVersion',
      ($0.GetMinimumKinVersionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMinimumKinVersionResponse.fromBuffer(value));
  static final _$getRecentBlockhash = $grpc.ClientMethod<
          $0.GetRecentBlockhashRequest, $0.GetRecentBlockhashResponse>(
      '/kin.agora.transaction.v4.Transaction/GetRecentBlockhash',
      ($0.GetRecentBlockhashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetRecentBlockhashResponse.fromBuffer(value));
  static final _$getMinimumBalanceForRentExemption = $grpc.ClientMethod<
          $0.GetMinimumBalanceForRentExemptionRequest,
          $0.GetMinimumBalanceForRentExemptionResponse>(
      '/kin.agora.transaction.v4.Transaction/GetMinimumBalanceForRentExemption',
      ($0.GetMinimumBalanceForRentExemptionRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMinimumBalanceForRentExemptionResponse.fromBuffer(value));
  static final _$getHistory =
      $grpc.ClientMethod<$0.GetHistoryRequest, $0.GetHistoryResponse>(
          '/kin.agora.transaction.v4.Transaction/GetHistory',
          ($0.GetHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetHistoryResponse.fromBuffer(value));
  static final _$signTransaction =
      $grpc.ClientMethod<$0.SignTransactionRequest, $0.SignTransactionResponse>(
          '/kin.agora.transaction.v4.Transaction/SignTransaction',
          ($0.SignTransactionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SignTransactionResponse.fromBuffer(value));
  static final _$submitTransaction = $grpc.ClientMethod<
          $0.SubmitTransactionRequest, $0.SubmitTransactionResponse>(
      '/kin.agora.transaction.v4.Transaction/SubmitTransaction',
      ($0.SubmitTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SubmitTransactionResponse.fromBuffer(value));
  static final _$getTransaction =
      $grpc.ClientMethod<$0.GetTransactionRequest, $0.GetTransactionResponse>(
          '/kin.agora.transaction.v4.Transaction/GetTransaction',
          ($0.GetTransactionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetTransactionResponse.fromBuffer(value));

  TransactionClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetServiceConfigResponse> getServiceConfig(
      $0.GetServiceConfigRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getServiceConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMinimumKinVersionResponse> getMinimumKinVersion(
      $0.GetMinimumKinVersionRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getMinimumKinVersion, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetRecentBlockhashResponse> getRecentBlockhash(
      $0.GetRecentBlockhashRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getRecentBlockhash, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMinimumBalanceForRentExemptionResponse>
      getMinimumBalanceForRentExemption(
          $0.GetMinimumBalanceForRentExemptionRequest request,
          {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getMinimumBalanceForRentExemption, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetHistoryResponse> getHistory(
      $0.GetHistoryRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.SignTransactionResponse> signTransaction(
      $0.SignTransactionRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$signTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$0.SubmitTransactionResponse> submitTransaction(
      $0.SubmitTransactionRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$submitTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransactionResponse> getTransaction(
      $0.GetTransactionRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getTransaction, request, options: options);
  }
}

abstract class TransactionServiceBase extends $grpc.Service {
  $core.String get $name => 'kin.agora.transaction.v4.Transaction';

  TransactionServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetServiceConfigRequest,
            $0.GetServiceConfigResponse>(
        'GetServiceConfig',
        getServiceConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetServiceConfigRequest.fromBuffer(value),
        ($0.GetServiceConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMinimumKinVersionRequest,
            $0.GetMinimumKinVersionResponse>(
        'GetMinimumKinVersion',
        getMinimumKinVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMinimumKinVersionRequest.fromBuffer(value),
        ($0.GetMinimumKinVersionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecentBlockhashRequest,
            $0.GetRecentBlockhashResponse>(
        'GetRecentBlockhash',
        getRecentBlockhash_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecentBlockhashRequest.fromBuffer(value),
        ($0.GetRecentBlockhashResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMinimumBalanceForRentExemptionRequest,
            $0.GetMinimumBalanceForRentExemptionResponse>(
        'GetMinimumBalanceForRentExemption',
        getMinimumBalanceForRentExemption_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMinimumBalanceForRentExemptionRequest.fromBuffer(value),
        ($0.GetMinimumBalanceForRentExemptionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetHistoryRequest, $0.GetHistoryResponse>(
        'GetHistory',
        getHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetHistoryRequest.fromBuffer(value),
        ($0.GetHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SignTransactionRequest,
            $0.SignTransactionResponse>(
        'SignTransaction',
        signTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SignTransactionRequest.fromBuffer(value),
        ($0.SignTransactionResponse value) => value.writeToBuffer()));
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

  $async.Future<$0.GetServiceConfigResponse> getServiceConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetServiceConfigRequest> request) async {
    return getServiceConfig(call, await request);
  }

  $async.Future<$0.GetMinimumKinVersionResponse> getMinimumKinVersion_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMinimumKinVersionRequest> request) async {
    return getMinimumKinVersion(call, await request);
  }

  $async.Future<$0.GetRecentBlockhashResponse> getRecentBlockhash_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetRecentBlockhashRequest> request) async {
    return getRecentBlockhash(call, await request);
  }

  $async.Future<$0.GetMinimumBalanceForRentExemptionResponse>
      getMinimumBalanceForRentExemption_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetMinimumBalanceForRentExemptionRequest>
              request) async {
    return getMinimumBalanceForRentExemption(call, await request);
  }

  $async.Future<$0.GetHistoryResponse> getHistory_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetHistoryRequest> request) async {
    return getHistory(call, await request);
  }

  $async.Future<$0.SignTransactionResponse> signTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SignTransactionRequest> request) async {
    return signTransaction(call, await request);
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

  $async.Future<$0.GetServiceConfigResponse> getServiceConfig(
      $grpc.ServiceCall call, $0.GetServiceConfigRequest request);
  $async.Future<$0.GetMinimumKinVersionResponse> getMinimumKinVersion(
      $grpc.ServiceCall call, $0.GetMinimumKinVersionRequest request);
  $async.Future<$0.GetRecentBlockhashResponse> getRecentBlockhash(
      $grpc.ServiceCall call, $0.GetRecentBlockhashRequest request);
  $async.Future<$0.GetMinimumBalanceForRentExemptionResponse>
      getMinimumBalanceForRentExemption($grpc.ServiceCall call,
          $0.GetMinimumBalanceForRentExemptionRequest request);
  $async.Future<$0.GetHistoryResponse> getHistory(
      $grpc.ServiceCall call, $0.GetHistoryRequest request);
  $async.Future<$0.SignTransactionResponse> signTransaction(
      $grpc.ServiceCall call, $0.SignTransactionRequest request);
  $async.Future<$0.SubmitTransactionResponse> submitTransaction(
      $grpc.ServiceCall call, $0.SubmitTransactionRequest request);
  $async.Future<$0.GetTransactionResponse> getTransaction(
      $grpc.ServiceCall call, $0.GetTransactionRequest request);
}
