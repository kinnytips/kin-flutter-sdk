import 'package:grpc/grpc.dart' show ClientChannel, GrpcError;
import 'package:grpc/src/shared/status.dart';
import 'package:kin_base/base/tools/network_operations_handler.dart';

class UnrecognizedProtoResponse extends Error {
  final String message =
      "Unrecognized Response format...possible breaking proto changes";

  UnrecognizedProtoResponse();

  @override
  String toString() {
    return 'UnrecognizedProtoResponse{message: $message}';
  }
}

class UnrecognizedResultException implements Exception {
  final String message = "Received an unknown result type";

  final Error cause;

  UnrecognizedResultException([this.cause]);

  @override
  String toString() {
    return 'UnrecognizedResultException{message: $message}';
  }
}

abstract class GrpcApi {
  static final Set<int> _retryableStatus = Set.from([
    StatusCode.unknown,
    StatusCode.cancelled,
    StatusCode.deadlineExceeded,
    StatusCode.aborted,
    StatusCode.internal,
    StatusCode.unavailable
  ]);

  static bool canRetry(Exception e) {
    return (e is GrpcError && _retryableStatus.contains(e.code)) || (e is NetworkOperationsHandlerTimeoutException) ;
  }

  static bool isForcedUpgrade(Exception e) {
    return (e is GrpcError && e.code == StatusCode.failedPrecondition ) ;
  }


  final ClientChannel managedChannel;

  GrpcApi(this.managedChannel);

}
