///
//  Generated code. Do not modify.
//  source: account/v4/account_service.proto
//

// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'account_service.pb.dart' as $2;
export 'account_service.pb.dart';

class AccountClient extends $grpc.Client {
  static final _$createAccount =
      $grpc.ClientMethod<$2.CreateAccountRequest, $2.CreateAccountResponse>(
          '/kin.agora.account.v4.Account/CreateAccount',
          ($2.CreateAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.CreateAccountResponse.fromBuffer(value));
  static final _$getAccountInfo =
      $grpc.ClientMethod<$2.GetAccountInfoRequest, $2.GetAccountInfoResponse>(
          '/kin.agora.account.v4.Account/GetAccountInfo',
          ($2.GetAccountInfoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.GetAccountInfoResponse.fromBuffer(value));
  static final _$resolveTokenAccounts = $grpc.ClientMethod<
          $2.ResolveTokenAccountsRequest, $2.ResolveTokenAccountsResponse>(
      '/kin.agora.account.v4.Account/ResolveTokenAccounts',
      ($2.ResolveTokenAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.ResolveTokenAccountsResponse.fromBuffer(value));
  static final _$getEvents = $grpc.ClientMethod<$2.GetEventsRequest, $2.Events>(
      '/kin.agora.account.v4.Account/GetEvents',
      ($2.GetEventsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Events.fromBuffer(value));

  AccountClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.CreateAccountResponse> createAccount(
      $2.CreateAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAccount, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetAccountInfoResponse> getAccountInfo(
      $2.GetAccountInfoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountInfo, request, options: options);
  }

  $grpc.ResponseFuture<$2.ResolveTokenAccountsResponse> resolveTokenAccounts(
      $2.ResolveTokenAccountsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveTokenAccounts, request, options: options);
  }

  $grpc.ResponseStream<$2.Events> getEvents($2.GetEventsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getEvents, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class AccountServiceBase extends $grpc.Service {
  $core.String get $name => 'kin.agora.account.v4.Account';

  AccountServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$2.CreateAccountRequest, $2.CreateAccountResponse>(
            'CreateAccount',
            createAccount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.CreateAccountRequest.fromBuffer(value),
            ($2.CreateAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetAccountInfoRequest,
            $2.GetAccountInfoResponse>(
        'GetAccountInfo',
        getAccountInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.GetAccountInfoRequest.fromBuffer(value),
        ($2.GetAccountInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ResolveTokenAccountsRequest,
            $2.ResolveTokenAccountsResponse>(
        'ResolveTokenAccounts',
        resolveTokenAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.ResolveTokenAccountsRequest.fromBuffer(value),
        ($2.ResolveTokenAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetEventsRequest, $2.Events>(
        'GetEvents',
        getEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $2.GetEventsRequest.fromBuffer(value),
        ($2.Events value) => value.writeToBuffer()));
  }

  $async.Future<$2.CreateAccountResponse> createAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.CreateAccountRequest> request) async {
    return createAccount(call, await request);
  }

  $async.Future<$2.GetAccountInfoResponse> getAccountInfo_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.GetAccountInfoRequest> request) async {
    return getAccountInfo(call, await request);
  }

  $async.Future<$2.ResolveTokenAccountsResponse> resolveTokenAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.ResolveTokenAccountsRequest> request) async {
    return resolveTokenAccounts(call, await request);
  }

  $async.Stream<$2.Events> getEvents_Pre($grpc.ServiceCall call,
      $async.Future<$2.GetEventsRequest> request) async* {
    yield* getEvents(call, await request);
  }

  $async.Future<$2.CreateAccountResponse> createAccount(
      $grpc.ServiceCall call, $2.CreateAccountRequest request);
  $async.Future<$2.GetAccountInfoResponse> getAccountInfo(
      $grpc.ServiceCall call, $2.GetAccountInfoRequest request);
  $async.Future<$2.ResolveTokenAccountsResponse> resolveTokenAccounts(
      $grpc.ServiceCall call, $2.ResolveTokenAccountsRequest request);
  $async.Stream<$2.Events> getEvents(
      $grpc.ServiceCall call, $2.GetEventsRequest request);
}
