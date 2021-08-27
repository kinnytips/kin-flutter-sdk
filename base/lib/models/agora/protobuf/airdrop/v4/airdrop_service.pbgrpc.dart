///
//  Generated code. Do not modify.
//  source: airdrop/v4/airdrop_service.proto
//

// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'airdrop_service.pb.dart' as $5;
export 'airdrop_service.pb.dart';

class AirdropClient extends $grpc.Client {
  static final _$requestAirdrop =
      $grpc.ClientMethod<$5.RequestAirdropRequest, $5.RequestAirdropResponse>(
          '/kin.agora.airdrop.v4.Airdrop/RequestAirdrop',
          ($5.RequestAirdropRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.RequestAirdropResponse.fromBuffer(value));

  AirdropClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$5.RequestAirdropResponse> requestAirdrop(
      $5.RequestAirdropRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestAirdrop, request, options: options);
  }
}

abstract class AirdropServiceBase extends $grpc.Service {
  $core.String get $name => 'kin.agora.airdrop.v4.Airdrop';

  AirdropServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.RequestAirdropRequest,
            $5.RequestAirdropResponse>(
        'RequestAirdrop',
        requestAirdrop_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.RequestAirdropRequest.fromBuffer(value),
        ($5.RequestAirdropResponse value) => value.writeToBuffer()));
  }

  $async.Future<$5.RequestAirdropResponse> requestAirdrop_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.RequestAirdropRequest> request) async {
    return requestAirdrop(call, await request);
  }

  $async.Future<$5.RequestAirdropResponse> requestAirdrop(
      $grpc.ServiceCall call, $5.RequestAirdropRequest request);
}
