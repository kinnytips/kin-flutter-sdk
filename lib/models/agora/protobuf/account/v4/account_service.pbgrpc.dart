///
//  Generated code. Do not modify.
//  source: account/v4/account_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'account_service.pb.dart' as $0;
export 'account_service.pb.dart';

class AccountClient extends $grpc.Client {
  static final _$createAccount =
      $grpc.ClientMethod<$0.CreateAccountRequest, $0.CreateAccountResponse>(
          '/kin.agora.account.v4.Account/CreateAccount',
          ($0.CreateAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateAccountResponse.fromBuffer(value));
  static final _$getAccountInfo =
      $grpc.ClientMethod<$0.GetAccountInfoRequest, $0.GetAccountInfoResponse>(
          '/kin.agora.account.v4.Account/GetAccountInfo',
          ($0.GetAccountInfoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetAccountInfoResponse.fromBuffer(value));
  static final _$resolveTokenAccounts = $grpc.ClientMethod<
          $0.ResolveTokenAccountsRequest, $0.ResolveTokenAccountsResponse>(
      '/kin.agora.account.v4.Account/ResolveTokenAccounts',
      ($0.ResolveTokenAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ResolveTokenAccountsResponse.fromBuffer(value));
  static final _$getEvents = $grpc.ClientMethod<$0.GetEventsRequest, $0.Events>(
      '/kin.agora.account.v4.Account/GetEvents',
      ($0.GetEventsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Events.fromBuffer(value));

  AccountClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateAccountResponse> createAccount(
      $0.CreateAccountRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$createAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountInfoResponse> getAccountInfo(
      $0.GetAccountInfoRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getAccountInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResolveTokenAccountsResponse> resolveTokenAccounts(
      $0.ResolveTokenAccountsRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$resolveTokenAccounts, request, options: options);
  }

  $grpc.ResponseStream<$0.Events> getEvents($0.GetEventsRequest request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(
        _$getEvents, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class AccountServiceBase extends $grpc.Service {
  $core.String get $name => 'kin.agora.account.v4.Account';

  AccountServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.CreateAccountRequest, $0.CreateAccountResponse>(
            'CreateAccount',
            createAccount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateAccountRequest.fromBuffer(value),
            ($0.CreateAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountInfoRequest,
            $0.GetAccountInfoResponse>(
        'GetAccountInfo',
        getAccountInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountInfoRequest.fromBuffer(value),
        ($0.GetAccountInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResolveTokenAccountsRequest,
            $0.ResolveTokenAccountsResponse>(
        'ResolveTokenAccounts',
        resolveTokenAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResolveTokenAccountsRequest.fromBuffer(value),
        ($0.ResolveTokenAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetEventsRequest, $0.Events>(
        'GetEvents',
        getEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.GetEventsRequest.fromBuffer(value),
        ($0.Events value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateAccountResponse> createAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateAccountRequest> request) async {
    return createAccount(call, await request);
  }

  $async.Future<$0.GetAccountInfoResponse> getAccountInfo_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAccountInfoRequest> request) async {
    return getAccountInfo(call, await request);
  }

  $async.Future<$0.ResolveTokenAccountsResponse> resolveTokenAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ResolveTokenAccountsRequest> request) async {
    return resolveTokenAccounts(call, await request);
  }

  $async.Stream<$0.Events> getEvents_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetEventsRequest> request) async* {
    yield* getEvents(call, await request);
  }

  $async.Future<$0.CreateAccountResponse> createAccount(
      $grpc.ServiceCall call, $0.CreateAccountRequest request);
  $async.Future<$0.GetAccountInfoResponse> getAccountInfo(
      $grpc.ServiceCall call, $0.GetAccountInfoRequest request);
  $async.Future<$0.ResolveTokenAccountsResponse> resolveTokenAccounts(
      $grpc.ServiceCall call, $0.ResolveTokenAccountsRequest request);
  $async.Stream<$0.Events> getEvents(
      $grpc.ServiceCall call, $0.GetEventsRequest request);
}
