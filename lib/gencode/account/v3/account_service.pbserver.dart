///
//  Generated code. Do not modify.
//  source: account/v3/account_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'account_service.pb.dart' as $3;
import 'account_service.pbjson.dart';

export 'account_service.pb.dart';

abstract class AccountServiceBase extends $pb.GeneratedService {
  $async.Future<$3.CreateAccountResponse> createAccount($pb.ServerContext ctx, $3.CreateAccountRequest request);
  $async.Future<$3.GetAccountInfoResponse> getAccountInfo($pb.ServerContext ctx, $3.GetAccountInfoRequest request);
  $async.Future<$3.Events> getEvents($pb.ServerContext ctx, $3.GetEventsRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'CreateAccount': return $3.CreateAccountRequest();
      case 'GetAccountInfo': return $3.GetAccountInfoRequest();
      case 'GetEvents': return $3.GetEventsRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'CreateAccount': return this.createAccount(ctx, request);
      case 'GetAccountInfo': return this.getAccountInfo(ctx, request);
      case 'GetEvents': return this.getEvents(ctx, request);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => AccountServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => AccountServiceBase$messageJson;
}

