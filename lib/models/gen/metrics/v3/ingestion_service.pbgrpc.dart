///
//  Generated code. Do not modify.
//  source: metrics/v3/ingestion_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ingestion_service.pb.dart' as $0;
export 'ingestion_service.pb.dart';

class IngestionClient extends $grpc.Client {
  static final _$submit =
      $grpc.ClientMethod<$0.SubmitRequest, $0.SubmitResponse>(
          '/kin.agora.metrics.v3.Ingestion/Submit',
          ($0.SubmitRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SubmitResponse.fromBuffer(value));

  IngestionClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.SubmitResponse> submit($0.SubmitRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$submit, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class IngestionServiceBase extends $grpc.Service {
  $core.String get $name => 'kin.agora.metrics.v3.Ingestion';

  IngestionServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SubmitRequest, $0.SubmitResponse>(
        'Submit',
        submit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SubmitRequest.fromBuffer(value),
        ($0.SubmitResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SubmitResponse> submit_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SubmitRequest> request) async {
    return submit(call, await request);
  }

  $async.Future<$0.SubmitResponse> submit(
      $grpc.ServiceCall call, $0.SubmitRequest request);
}
