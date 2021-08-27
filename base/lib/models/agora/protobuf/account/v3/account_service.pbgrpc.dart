///
//  Generated code. Do not modify.
//  source: account/v3/account_service.proto
//

// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'account_service.pb.dart' as $3;
export 'account_service.pb.dart';

class AccountClient extends $grpc.Client {
  static final _$createAccount =
      $grpc.ClientMethod<$3.CreateAccountRequest, $3.CreateAccountResponse>(
          '/kin.agora.account.v3.Account/CreateAccount',
          ($3.CreateAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $3.CreateAccountResponse.fromBuffer(value));
  static final _$getAccountInfo =
      $grpc.ClientMethod<$3.GetAccountInfoRequest, $3.GetAccountInfoResponse>(
          '/kin.agora.account.v3.Account/GetAccountInfo',
          ($3.GetAccountInfoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $3.GetAccountInfoResponse.fromBuffer(value));
  static final _$getEvents = $grpc.ClientMethod<$3.GetEventsRequest, $3.Events>(
      '/kin.agora.account.v3.Account/GetEvents',
      ($3.GetEventsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Events.fromBuffer(value));

  AccountClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$3.CreateAccountResponse> createAccount(
      $3.CreateAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAccount, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetAccountInfoResponse> getAccountInfo(
      $3.GetAccountInfoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountInfo, request, options: options);
  }

  $grpc.ResponseStream<$3.Events> getEvents($3.GetEventsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getEvents, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class AccountServiceBase extends $grpc.Service {
  $core.String get $name => 'kin.agora.account.v3.Account';

  AccountServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$3.CreateAccountRequest, $3.CreateAccountResponse>(
            'CreateAccount',
            createAccount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.CreateAccountRequest.fromBuffer(value),
            ($3.CreateAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetAccountInfoRequest,
            $3.GetAccountInfoResponse>(
        'GetAccountInfo',
        getAccountInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.GetAccountInfoRequest.fromBuffer(value),
        ($3.GetAccountInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetEventsRequest, $3.Events>(
        'GetEvents',
        getEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $3.GetEventsRequest.fromBuffer(value),
        ($3.Events value) => value.writeToBuffer()));
  }

  $async.Future<$3.CreateAccountResponse> createAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.CreateAccountRequest> request) async {
    return createAccount(call, await request);
  }

  $async.Future<$3.GetAccountInfoResponse> getAccountInfo_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.GetAccountInfoRequest> request) async {
    return getAccountInfo(call, await request);
  }

  $async.Stream<$3.Events> getEvents_Pre($grpc.ServiceCall call,
      $async.Future<$3.GetEventsRequest> request) async* {
    yield* getEvents(call, await request);
  }

  $async.Future<$3.CreateAccountResponse> createAccount(
      $grpc.ServiceCall call, $3.CreateAccountRequest request);
  $async.Future<$3.GetAccountInfoResponse> getAccountInfo(
      $grpc.ServiceCall call, $3.GetAccountInfoRequest request);
  $async.Stream<$3.Events> getEvents(
      $grpc.ServiceCall call, $3.GetEventsRequest request);
}
