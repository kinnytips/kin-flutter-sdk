
import 'dart:math';

import 'package:kin_base/base/tools/promises.dart';

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
  final int after;
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
    int maxAttempts}) : super(maxAttempts) ;
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
  static const Duration DEFAULT_MAX_ATTEMPT_WAIT_TIME = Duration(milliseconds:  15000);
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

  static String generateRandomId() =>
      _randomSource.nextInt(8611686018427388000).toString();

  final PromisedCallback<T> onCompleted;
  final String id;

  final Duration timeout;

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


  NetworkOperationState _state = NetworkOperationState.init ;

  NetworkOperationState get state => _state;

  set state(NetworkOperationState value) {
    var prevState = _state ;
    if (prevState is NetworkOperationStateScheduled) {
      prevState.cancellable?.cancel();
    }
    _state = value;
  }

  ScheduledFuture expiryFuture ;

  void _expire() {
    var error = NetworkOperationsHandlerTimeoutException();
    _error(error);
  }

  void _error(Error error) {
    state = NetworkOperationStateErrored(error);
    _notifyError(error);
    _cleanup();
  }

  void _notifyError(NetworkOperationsHandlerTimeoutException error) {
    var onError = onCompleted?.onError;
    if (onError != null) {
      onError(error);
    }
  }

  void _cleanup() {
    if (expiryFuture != null) {
      expiryFuture.cancel();
      expiryFuture = null ;
    }
  }

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
  NetworkOperation<T> queueOperation<T>(NetworkOperation<T> op) ;
}

class NetworkOperationsHandlerImpl extends NetworkOperationsHandler {
  final ScheduledExecutorService _ioScheduler ;
  final ExecutorService _ioExecutor ;
  final KinLoggerFactory _logger ;
  final bool Function(Error error) _shouldRetryError ;

  KinLogger _log ;

  NetworkOperationsHandlerImpl(
      {ScheduledExecutorService ioScheduler,
      ExecutorService ioExecutor,
      KinLoggerFactory logger,
      bool Function(Error error) shouldRetryError})
      : _ioScheduler = ioScheduler ?? ExecutorService.createScheduled(),
        _ioExecutor = ioExecutor ?? ExecutorService.createSequencial(),
        _logger = logger,
        _shouldRetryError = shouldRetryError ?? ((_) => false) {
    _log = _logger.getLogger('$runtimeType');
  }

  final Map<String, NetworkOperation> _operations = <String, NetworkOperation>{} ;

  @override
  NetworkOperation<T> queueOperation<T>(NetworkOperation<T> op) {
    op.state = NetworkOperationState.queued;

    _operations[op.id] = op ;

    _ioScheduler.schedule(() {
      _expire(op);
    }, op.timeout);

    _schedule(op);

    return op;
  }

  void _schedule<T>(NetworkOperation<T> op, [Error error]) {
    _log.log("schedule[id=${op.id}]");

    var delayMillis ;
    try {
      delayMillis = op.backoffStrategy.nextDelay();
    } catch (e) {
      var opState = op.state;
      if ( opState is NetworkOperationStateErrored ) {
        _fatalError(op, opState.error);
      }
      else {
        _fatalError(op, e);
      }
      return ;
    }

    _log.log("delayMillis[id=${op.id}]: + $delayMillis");

    var scheduledFuture = _ioScheduler.schedule(() {
      _ioExecutor.execute(() {
        _runOperation(op, error);
      });
    }, Duration(milliseconds: delayMillis)) ;

    op.state = NetworkOperationStateScheduled(
      DateTime.now().millisecondsSinceEpoch + delayMillis,
      scheduledFuture,
    );
  }

  void _runOperation<T>(NetworkOperation<T> op, [Error error]) {
    _log.log("runOperation[id=${op.id}]");

    op.state = NetworkOperationState.running;

    try {
      op.callback(
          PromisedCallback( (e) {
            _complete(op);
            op?.onCompleted?.onSuccess(e);
          } , (e) => _handleError(op, e) )
      );
    }
    catch(e) {
      _handleError(op, e);
    }

  }


  void _complete<T>(NetworkOperation<T> op) {
    _log.log("complete[id=${op.id}]");
    op.state = NetworkOperationState.completed;
    _cleanup(op);
  }

  void _handleError<T>(NetworkOperation<T> op, Error error) {
    _log.log("handleError[id=${op.id}]: $e");

    if ( ( op.shouldRetryError != null && op.shouldRetryError(error) ) || this._shouldRetryError(error) ) {
      op.state = NetworkOperationStateErrored(error);
      _schedule(op);
    }
    else {
      _fatalError(op, error);
    }
  }

  void _fatalError<T>(NetworkOperation<T> op, Error error) {
    _log.log("fatalError[id=${op.id}]: $e");
    op._error(error);
    _cleanup(op);
  }

  void _expire<T>(NetworkOperation<T> op) {
    op._expire();
    _cleanup(op);
  }

  void _cleanup<T>(NetworkOperation<T> op) {
    op._cleanup();
    _operations.remove(op.id);
  }

}

/*


class NetworkOperationsHandlerImpl(
    private val ioScheduler: ScheduledExecutorService = Executors.newSingleThreadScheduledExecutor(),
    private val ioExecutor: ExecutorService = Executors.newScheduledThreadPool(
        Runtime.getRuntime().availableProcessors()
    ),
    private val logger: KinLoggerFactory,
    private val shouldRetryError: (Throwable) -> Boolean = { false }
) : NetworkOperationsHandler {
    private val operations = hashMapOf<String, NetworkOperation<*>>()
    private val log = logger.getLogger(javaClass.simpleName)

    override fun <ResponseType> queueOperation(op: NetworkOperation<ResponseType>): NetworkOperation<ResponseType> {
        return op.apply {
            state = NetworkOperation.State.QUEUED
            expiryFuture = ioScheduler.schedule(
                { expire() },
                timeout,
                TimeUnit.MILLISECONDS
            )
            synchronized(operations) { operations[id] = op }
            schedule()
        }
    }


    private fun NetworkOperation<*>.schedule(error: Throwable? = null) {
        log.log("schedule[id=$id]")
        val delayMillis = try {
            backoffStrategy.nextDelay()
        } catch (e: Throwable) {
            (state as? NetworkOperation.State.ERRORED)?.let {
                fatalError(it.error.apply { addSuppressed(e) })
            } ?: fatalError(e)
            return
        }
        log.log("delayMillis[id=$id]: + $delayMillis")

        state = NetworkOperation.State.SCHEDULED(
            System.currentTimeMillis() + delayMillis,
            ioScheduler.schedule(
                { ioExecutor.submit { runOperation(error) } },
                delayMillis,
                TimeUnit.MILLISECONDS
            )
        )
    }

    private fun <ResponseType> NetworkOperation<ResponseType>.runOperation(error: Throwable? = null) = apply {
        log.log("runOperation[id=$id]")
        state = NetworkOperation.State.RUNNING

        try {
            callback(PromisedCallback({
                complete()
                onCompleted.onSuccess(it)
            }, { handleError(it) }), error)
        } catch (error: Throwable) {
            handleError(error)
        }
    }

}


 */
