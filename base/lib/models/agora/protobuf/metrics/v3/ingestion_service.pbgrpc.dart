///
//  Generated code. Do not modify.
//  source: metrics/v3/ingestion_service.proto
//

// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ingestion_service.pb.dart' as $4;
export 'ingestion_service.pb.dart';

class IngestionClient extends $grpc.Client {
  static final _$submit =
      $grpc.ClientMethod<$4.SubmitRequest, $4.SubmitResponse>(
          '/kin.agora.metrics.v3.Ingestion/Submit',
          ($4.SubmitRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.SubmitResponse.fromBuffer(value));

  IngestionClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$4.SubmitResponse> submit($4.SubmitRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submit, request, options: options);
  }
}

abstract class IngestionServiceBase extends $grpc.Service {
  $core.String get $name => 'kin.agora.metrics.v3.Ingestion';

  IngestionServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.SubmitRequest, $4.SubmitResponse>(
        'Submit',
        submit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.SubmitRequest.fromBuffer(value),
        ($4.SubmitResponse value) => value.writeToBuffer()));
  }

  $async.Future<$4.SubmitResponse> submit_Pre(
      $grpc.ServiceCall call, $async.Future<$4.SubmitRequest> request) async {
    return submit(call, await request);
  }

  $async.Future<$4.SubmitResponse> submit(
      $grpc.ServiceCall call, $4.SubmitRequest request);
}
