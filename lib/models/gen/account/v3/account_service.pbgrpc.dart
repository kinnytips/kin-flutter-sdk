///
//  Generated code. Do not modify.
//  source: account/v3/account_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'account_service.pb.dart' as $0;
export 'account_service.pb.dart';

class AccountClient extends $grpc.Client {
  static final _$createAccount =
      $grpc.ClientMethod<$0.CreateAccountRequest, $0.CreateAccountResponse>(
          '/kin.agora.account.v3.Account/CreateAccount',
          ($0.CreateAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateAccountResponse.fromBuffer(value));
  static final _$getAccountInfo =
      $grpc.ClientMethod<$0.GetAccountInfoRequest, $0.GetAccountInfoResponse>(
          '/kin.agora.account.v3.Account/GetAccountInfo',
          ($0.GetAccountInfoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetAccountInfoResponse.fromBuffer(value));
  static final _$getEvents = $grpc.ClientMethod<$0.GetEventsRequest, $0.Events>(
      '/kin.agora.account.v3.Account/GetEvents',
      ($0.GetEventsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Events.fromBuffer(value));

  AccountClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.CreateAccountResponse> createAccount(
      $0.CreateAccountRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createAccount, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.GetAccountInfoResponse> getAccountInfo(
      $0.GetAccountInfoRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getAccountInfo, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.Events> getEvents($0.GetEventsRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getEvents, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class AccountServiceBase extends $grpc.Service {
  $core.String get $name => 'kin.agora.account.v3.Account';

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

  $async.Stream<$0.Events> getEvents_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetEventsRequest> request) async* {
    yield* getEvents(call, await request);
  }

  $async.Future<$0.CreateAccountResponse> createAccount(
      $grpc.ServiceCall call, $0.CreateAccountRequest request);
  $async.Future<$0.GetAccountInfoResponse> getAccountInfo(
      $grpc.ServiceCall call, $0.GetAccountInfoRequest request);
  $async.Stream<$0.Events> getEvents(
      $grpc.ServiceCall call, $0.GetEventsRequest request);
}
