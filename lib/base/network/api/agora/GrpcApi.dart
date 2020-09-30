import 'package:grpc/src/shared/status.dart';

abstract class GrpcApi {
  GrpcApi(ManagedChannel managedChannel)

  void RETRYABLE_STATUS = setOf(
      StatusCode.unknown,
      StatusCode.cancelled,
      StatusCode.deadlineExceeded,
      StatusCode.aborted,
      StatusCode.internal,
      StatusCode.unavailable);

  static void setOf(unknown, cancelled, deadline_exceeded, aborted, internal, unavailable) {}
}