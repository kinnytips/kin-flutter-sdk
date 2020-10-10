///
//  Generated code. Do not modify.
//  source: metrics/v3/ingestion_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'ingestion_service.pb.dart' as $0;
import 'ingestion_service.pbjson.dart';

export 'ingestion_service.pb.dart';

abstract class IngestionServiceBase extends $pb.GeneratedService {
  $async.Future<$0.SubmitResponse> submit($pb.ServerContext ctx, $0.SubmitRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'Submit': return $0.SubmitRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'Submit': return this.submit(ctx, request);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => IngestionServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => IngestionServiceBase$messageJson;
}

