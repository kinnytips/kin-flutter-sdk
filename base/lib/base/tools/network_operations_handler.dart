
import 'dart:async';
import 'dart:math';

import 'package:kin_base/base/tools/extensions.dart';

import 'executor_service.dart';
import 'kin_logger.dart';

class RetriesExceededException extends Error {
  String message ;

  RetriesExceededException([this.message = '?']);

  @override
  String toString() {
    return 'RetriesExceededException{message: $message}';
  }
}

class NetworkOperationsHandlerException extends Error {
  String message ;

  NetworkOperationsHandlerException(this.message);

  @override
  String toString() {
    return '$runtimeType{message: $message}';
  }
}

class NetworkOperationsHandlerTimeoutException extends NetworkOperationsHandlerException {
  NetworkOperationsHandlerTimeoutException() : super('Op timed out');
}

class BackoffStrategyNever extends BackoffStrategy {

  BackoffStrategyNever([int maxAttempts = BackoffStrategy.DEFAULT_MAX_ATTEMPTS]) : super(maxAttempts) ;
}

class BackoffStrategyFixed extends BackoffStrategy {
  final int? after;
  BackoffStrategyFixed([this.after, int maxAttempts = BackoffStrategy.DEFAULT_MAX_ATTEMPTS]) : super(maxAttempts) ;
}

class BackoffStrategyExponential extends BackoffStrategy {
  final int initial ;
  final double multiplier ;
  final double jitter;
  final Duration maximumWaitTime;

  BackoffStrategyExponential({
    this.initial = 1000 ,
    this.multiplier = 2.0 ,
    this.jitter = 0.5 ,
    this.maximumWaitTime = BackoffStrategy.DEFAULT_MAX_ATTEMPT_WAIT_TIME,
    int maxAttempts = BackoffStrategy.DEFAULT_MAX_ATTEMPTS}) : super(maxAttempts) ;
}


class BackoffStrategyExponentialIncrease extends BackoffStrategy {
  final int initial ;
  final double multiplier ;
  final double jitter;
  final Duration maximumWaitTime;

  BackoffStrategyExponentialIncrease({
    this.initial = 1000 ,
    this.multiplier = 2.0 ,
    this.jitter = 0.5 ,
    this.maximumWaitTime = BackoffStrategy.DEFAULT_MAX_ATTEMPT_WAIT_TIME,
    int maxAttempts = BackoffStrategy.DEFAULT_MAX_ATTEMPTS}) : super(maxAttempts) ;
}

class BackoffStrategyCustom extends BackoffStrategy {
  final int? Function(int x) afterClosure ;
  final void Function() _reset ;

  BackoffStrategyCustom(this.afterClosure, this._reset, [int maxAttempts = BackoffStrategy.DEFAULT_MAX_ATTEMPTS]) : super(maxAttempts) ;

  @override
  void reset() {
    _reset();
  }
}

class BackoffStrategy {
  static const int DEFAULT_MAX_ATTEMPTS = 5 ;
  static const Duration DEFAULT_MAX_ATTEMPT_WAIT_TIME = Duration(milliseconds:  15000);
  static Random randomSource = Random();
  static const int InfiniteRetries = -1 ;

  final int maxAttempts ;

  BackoffStrategy([int maxAttempts = DEFAULT_MAX_ATTEMPTS]) : maxAttempts = maxAttempts ;

  static BackoffStrategy combine(List<BackoffStrategy> strategies) {
    var totalMaxAttempts = strategies.map((e) => e.maxAttempts).reduce((value, element) => value + element);

    return BackoffStrategyCustom(
      (currentAttempt) {
        var previousAttempts = 0;
        for (var it in strategies) {
          if ((currentAttempt - previousAttempts) < it.maxAttempts) {
            return it.nextDelay();
          } else {
            previousAttempts += it.maxAttempts;
          }
        }
        return -1;
      },
      () => strategies.forEach((e) => e.reset()),
      totalMaxAttempts,
    );
  }

  int currentAttempt = 0;

  int? nextDelay() => delayForAttempt(currentAttempt++) ;

   void reset() {
    currentAttempt = 0;
  }

  int? delayForAttempt(int attempt) {
    if (attempt >= maxAttempts && maxAttempts != InfiniteRetries) {
      throw RetriesExceededException();
    }

    // The first backoff attempt is attempt=1.
    if (attempt <= 0 && this is! BackoffStrategyCustom && this is! BackoffStrategyExponentialIncrease) {
      return 0 ;
    }

    BackoffStrategy o = this ;

    if (o is BackoffStrategyNever) {
      throw RetriesExceededException();
    }
    else if (o is BackoffStrategyFixed) {
      return o.after ;
    }
    else if (o is BackoffStrategyExponential) {
      var delay = o.initial * pow(o.multiplier , (attempt - 1)).toDouble() ;
      var jitterAmount = delay * o.jitter * randomSource.nextDouble();
      return min(o.maximumWaitTime.inMilliseconds, max(0, (delay + jitterAmount))).toInt() ;
    }
    else if (o is BackoffStrategyExponentialIncrease) {
      var delay = o.initial * pow(o.multiplier, (maxAttempts - attempt)).toDouble() ;
      var jitterAmount = delay * o.jitter * randomSource.nextDouble();
      return min(o.maximumWaitTime.inMilliseconds, max(0, (delay + jitterAmount))).toInt() ;
    }
    else if (o is BackoffStrategyCustom) {
      return o.afterClosure(attempt) ;
    }
    else {
      throw StateError("Can't handle strategy type: $this");
    }
  }

}

class NetworkOperation<T> {
  static const Duration DEFAULT_TIMEOUT = Duration(milliseconds: 50000);

  static final _randomSource = Random();
  static int _randomCounter = 0 ;

  static String generateRandomId() {
    var now = DateTime.now().millisecondsSinceEpoch ;
    var rand = _randomSource.nextInt(4294967295);
    var id = (rand ^ now) * 1000 ;

    // Ensures that is unique,
    // even with random collision (theoretically possible):
    id += ++_randomCounter ;

    return '$id';
  }

  final Completer<T> completer;

  Future<T> get onComplete => completer.future ;

  final String id;
  final String? name;

  final Duration timeout;

  final BackoffStrategy backoffStrategy;

  final Future<T> Function() task;

  final bool Function(Object error)? shouldRetryError;

  NetworkOperation(this.task, {
    String? id,
    this.name,
    this.timeout = DEFAULT_TIMEOUT,
    BackoffStrategy? backoffStrategy,
    this.shouldRetryError,
  })  : completer = Completer(),
        id = id ?? generateRandomId(),
        backoffStrategy = BackoffStrategyExponential(maximumWaitTime: timeout);


  NetworkOperationState _state = NetworkOperationState.init ;

  NetworkOperationState get state => _state;

  set state(NetworkOperationState value) {
    var prevState = _state ;
    if (prevState is NetworkOperationStateScheduled) {
      prevState.cancellable.cancel();
    }
    _state = value;
  }

  void _complete(T result) {
    state = NetworkOperationState.completed;
    if (!completer.isCompleted) {
      completer.complete(result);
    }
    else {
      throw StateError('Attempt to complete and already completed operation: op: $this > result: result');
    }
    _cleanup();
  }

  ScheduledFuture? expiryFuture ;

  void _expire() {
    if ( state == NetworkOperationState.completed  ) {
      throw StateError('Attempting to expire a completed operation: $this');
    }

    var error = NetworkOperationsHandlerTimeoutException();
    _error(error, null);
  }

  void _error(Object error, StackTrace? stackTrace) {
    state = NetworkOperationStateErrored(error);
    _notifyError(error, stackTrace);
    _cleanup();
  }

  void _notifyError(Object error, StackTrace? stackTrace) {
    if (!completer.isCompleted) {
      completer.completeError(error, stackTrace);
    }
  }

  void _cleanup() {
    if (expiryFuture != null) {
      expiryFuture!.cancel();
      expiryFuture = null ;
    }
  }

  @override
  String toString() {
    return 'NetworkOperation{id: $id' +
        (name != null && name!.isNotEmpty ? ', name: $name' : '') +
        '}';
  }
}

class NetworkOperationState {

  static final NetworkOperationState init = NetworkOperationState._('init');
  static final NetworkOperationState queued = NetworkOperationState._('queued');
  static final NetworkOperationState running = NetworkOperationState._('running');
  static final NetworkOperationState completed = NetworkOperationState._('completed');

  final String name ;

  NetworkOperationState._(this.name);

  @override
  String toString() {
    return '$runtimeType{$name}';
  }
}

class NetworkOperationStateScheduled<T> extends NetworkOperationState {
  int executionTimestamp ;
  ScheduledFuture cancellable ;

  NetworkOperationStateScheduled(this.executionTimestamp, this.cancellable) : super._('scheduled');
}

class NetworkOperationStateErrored extends NetworkOperationState {
  Object error ;

  NetworkOperationStateErrored(this.error) : super._('errored');
}

abstract class NetworkOperationsHandler {
  NetworkOperation<T> queueOperation<T>(NetworkOperation<T> op) ;

  Future<T> queueWork<T>( String name, Future<T> Function() work ) {
    var op = NetworkOperation( work , name: name ) ;
    return queueOperation(op).onComplete ;
  }
}

class NetworkOperationsHandlerImpl extends NetworkOperationsHandler {
  final ScheduledExecutorService _ioScheduler ;
  final ExecutorService _ioExecutor ;
  final KinLoggerFactory? _logger ;
  final bool Function(Object error) _shouldRetryError ;

  late KinLogger _log ;

  NetworkOperationsHandlerImpl(
      {ScheduledExecutorService? ioScheduler,
      ExecutorService? ioExecutor,
      KinLoggerFactory? logger,
      bool Function(Object error)? shouldRetryError})
      : _ioScheduler = ioScheduler ?? ExecutorService.createScheduled(),
        _ioExecutor = ioExecutor ?? ExecutorService.createSequencial(),
        _logger = logger,
        _shouldRetryError = shouldRetryError ?? ((_) => false) {
    _log = _logger!.getLogger('$runtimeType');
  }

  final Map<String, NetworkOperation> _operations = <String, NetworkOperation>{} ;

  @override
  NetworkOperation<T> queueOperation<T>(NetworkOperation<T> op) {
    op.state = NetworkOperationState.queued;

    _operations[op.id] = op ;

    _schedule(op);

    if ( op.timeout.inMilliseconds > 0 ) {
      _log.log("timeout> timeout: ${op.timeout} ; $op");
      _ioScheduler.schedule(() {
        _expire(op);
      }, op.timeout);
    }

    return op;
  }

  void _schedule<T>(NetworkOperation<T> op, [Error? error]) {
    var delayMillis ;
    try {
      delayMillis = op.backoffStrategy.nextDelay();
    } catch (e,s) {
      var opState = op.state;
      if ( opState is NetworkOperationStateErrored ) {
        _fatalError(op, opState.error, null);
      }
      else {
        _fatalError(op, e, s);
      }
      return ;
    }

    _log.log("schedule> $op > delayMillis: +$delayMillis");

    var scheduledFuture = _ioScheduler.schedule(() {
      _ioExecutor.execute(() {
        _runOperation(op, error);
      });
    }, Duration(milliseconds: delayMillis)) ;

    op.state = NetworkOperationStateScheduled(
      DateTime.now().millisecondsSinceEpoch + delayMillis as int,
      scheduledFuture,
    );
  }

  void _runOperation<T>(NetworkOperation<T> op, [Error? error]) async {
    _log.log("runOperation> $op");

    op.state = NetworkOperationState.running;

    try {
      var result = await op.task();
      _complete(op, result);
    }
    catch(e,s) {
      if (e is Exception) {
        _handleError(op, NetworkOperationError('Operation Exception', e), s);
      }
      else {
        _handleError(op, e, s);
      }
    }

  }

  void _complete<T>(NetworkOperation<T> op, T result) {
    _log.log("complete> $op");
    op._complete(result);
    _cleanup(op);
  }

  void _handleError<T>(NetworkOperation<T> op, Object error, StackTrace stackTrace) {
    _log.log("handleError> $op > ERROR: $error @ ${stackTrace.firstLine}");

    if ( ( op.shouldRetryError != null && op.shouldRetryError!(error) ) || this._shouldRetryError(error) ) {
      op.state = NetworkOperationStateErrored(error);
      _schedule(op);
    }
    else {
      _fatalError(op, error, stackTrace);
    }
  }

  void _fatalError<T>(NetworkOperation<T> op, Object error, StackTrace? stackTrace) {
    _log.log("fatalError> $op > ERROR: $error @ ${stackTrace?.firstLine ?? '?'}");
    op._error(error, stackTrace);
    _cleanup(op);
  }

  void _expire<T>(NetworkOperation<T> op) {
    if (_exists(op)) {
      _log.log("expire> $op");
      op._expire();
      _cleanup(op);
    }
  }

  void _cleanup<T>(NetworkOperation<T> op) {
    op._cleanup();
    _operations.remove(op.id);
  }

  bool _exists<T>(NetworkOperation<T> op) {
    return _operations.containsKey(op.id);
  }

}

class NetworkOperationError extends Error {
  String message ;
  dynamic cause ;

  NetworkOperationError(this.message, [this.cause]);

  @override
  String toString() {
    return 'NetworkOperationError{message: $message, cause: $cause}';
  }
}
