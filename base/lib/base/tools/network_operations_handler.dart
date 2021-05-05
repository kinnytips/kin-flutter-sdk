
import 'dart:math';

import 'package:kin_base/base/tools/promises.dart';

import 'executor_service.dart';

class RetriesExceededException extends Error {
  String message ;

  RetriesExceededException([this.message = '?']);

  @override
  String toString() {
    return 'RetriesExceededException{message: $message}';
  }
}

class BackoffStrategyNever extends BackoffStrategy {

  BackoffStrategyNever([int maxAttempts = BackoffStrategy.DEFAULT_MAX_ATTEMPTS]) : super(maxAttempts) ;
}

class BackoffStrategyFixed extends BackoffStrategy {
  final int after;
  BackoffStrategyFixed([this.after, int maxAttempts = BackoffStrategy.DEFAULT_MAX_ATTEMPTS]) : super(maxAttempts) ;
}

class BackoffStrategyExponential extends BackoffStrategy {
  final int initial ;
  final double multiplier ;
  final double jitter;
  final int maximumWaitTime;

  BackoffStrategyExponential({
    this.initial = 1000 ,
    this.multiplier = 2.0 ,
    this.jitter = 0.5 ,
    this.maximumWaitTime = BackoffStrategy.DEFAULT_MAX_ATTEMPT_WAIT_TIME,
    int maxAttempts}) : super(maxAttempts) ;
}


class BackoffStrategyExponentialIncrease extends BackoffStrategy {
  final int initial ;
  final double multiplier ;
  final double jitter;
  final int maximumWaitTime;

  BackoffStrategyExponentialIncrease({
    this.initial = 1000 ,
    this.multiplier = 2.0 ,
    this.jitter = 0.5 ,
    this.maximumWaitTime = BackoffStrategy.DEFAULT_MAX_ATTEMPT_WAIT_TIME,
    int maxAttempts}) : super(maxAttempts) ;
}

class BackoffStrategyCustom extends BackoffStrategy {
  final int Function(int x) afterClosure ;
  final void Function() _reset ;

  BackoffStrategyCustom(this.afterClosure, this._reset, [int maxAttempts = BackoffStrategy.DEFAULT_MAX_ATTEMPTS]) : super(maxAttempts) ;

  @override
  void reset() {
    _reset();
  }
}
class BackoffStrategy {
  static const int DEFAULT_MAX_ATTEMPTS = 5 ;
  static const int DEFAULT_MAX_ATTEMPT_WAIT_TIME = 15000;
  static Random randomSource = Random();
  static const int InfiniteRetries = -1 ;

  final int maxAttempts ;

  BackoffStrategy([this.maxAttempts = DEFAULT_MAX_ATTEMPTS]);

  int currentAttempt = 0;

  int nextDelay() => delayForAttempt(currentAttempt++) ;

   void reset() {
    currentAttempt = 0;
  }

  int delayForAttempt(int attempt) {
    if (attempt >= maxAttempts && maxAttempts != InfiniteRetries) {
      throw RetriesExceededException();
    }

    // The first backoff attempt is attempt=1.
    if (attempt <= 0 && this is! BackoffStrategyCustom && this is! BackoffStrategyExponentialIncrease) {
      return 0 ;
    }

    var o = this ;

    if (o is BackoffStrategyNever) {
      throw RetriesExceededException();
    }
    else if (o is BackoffStrategyFixed) {
      return o.after ;
    }
    else if (o is BackoffStrategyExponential) {
      var delay = o.initial * pow(o.multiplier , (attempt - 1)).toDouble() ;
      var jitterAmount = delay * o.jitter * randomSource.nextDouble();
      return min(o.maximumWaitTime, max(0, (delay + jitterAmount))).toInt() ;
    }
    else if (o is BackoffStrategyExponentialIncrease) {
      var delay = o.initial * pow(o.multiplier, (maxAttempts - attempt)).toDouble() ;
      var jitterAmount = delay * o.jitter * randomSource.nextDouble();
      return min(o.maximumWaitTime, max(0, (delay + jitterAmount))).toInt() ;
    }
    else if (o is BackoffStrategyCustom) {
      return o.afterClosure(attempt) ;
    }
  }

}

class NetworkOperation<T> {
  static const int DEFAULT_TIMEOUT = 50000;

  static final _randomSource = Random();

  static String generateRandomId() =>
      _randomSource.nextInt(8611686018427388000).toString();

  final PromisedCallback<T> onCompleted;
  final String id;

  final int timeout;

  final BackoffStrategy backoffStrategy;

  final void Function(PromisedCallback<T> promisedCallback,
      [Error error]) callback;

  final bool Function(Error error) shouldRetryError;

  NetworkOperation({
    PromisedCallback<T> onCompleted,
    void Function(T value) onSuccess,
    void Function(Error error) onError,
    String id,
    this.timeout = DEFAULT_TIMEOUT,
    BackoffStrategy backoffStrategy,
    this.callback,
    this.shouldRetryError,
  })  : onCompleted = onCompleted ?? PromisedCallback(onSuccess, onError),
        id = id ?? generateRandomId(),
        backoffStrategy = BackoffStrategyExponential(maximumWaitTime: timeout);
}

class NetworkOperationState {

  static final NetworkOperationState init = NetworkOperationState._();
  static final NetworkOperationState queued = NetworkOperationState._();
  static final NetworkOperationState running = NetworkOperationState._();
  static final NetworkOperationState completed = NetworkOperationState._();

  NetworkOperationState._();
}

class NetworkOperationStateScheduled<T> extends NetworkOperationState {
  int executionTimestamp ;
  ScheduledFuture cancellable ;

  NetworkOperationStateScheduled(this.executionTimestamp, this.cancellable) : super._();
}

class NetworkOperationStateErrored extends NetworkOperationState {
  Error error ;

  NetworkOperationStateErrored(this.error) : super._();
}

abstract class NetworkOperationsHandler {

  NetworkOperationState _state = NetworkOperationState.init ;

  NetworkOperationState get state => _state;

  set state(NetworkOperationState value) {
    var prevState = _state ;
    if (prevState is NetworkOperationStateScheduled) {
      prevState.cancellable?.cancel();
    }
    _state = value;
  }

  NetworkOperation<T> queueOperation<T>(NetworkOperation<T> op) ;
}
