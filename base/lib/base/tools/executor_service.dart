import 'dart:async';

typedef ExecutorTask<R> = FutureOr<R?> Function();

abstract class ExecutorService {
  static ExecutorService createSequencial() => _ExecutorServiceSequential() ;
  static ExecutorService createParallel() => _ExecutorServiceParallel();
  static ScheduledExecutorService createScheduled() => ScheduledExecutorService.create();

  Future<R?> execute<R>(ExecutorTask<R> task);
}

abstract class ScheduledExecutorService extends ExecutorService {
  static ScheduledExecutorService create() => _ExecutorServiceScheduled();

  ScheduledFuture<R?> schedule<R>(ExecutorTask<R> task, [Duration? delay]);
}

class ScheduledFuture<T> {
  final Duration? delay;
  ExecutorTask<T>? _task;

  Future<T>? _future;

  Future<T>? get future => _future;

  ScheduledFuture(this.delay, this._task);

  FutureOr<T?> executeTask() {
    if (_task == null) return null ;
    var ret = _task!();
    _task = null;
    return ret ;
  }

  void cancel() {
    _task = null;
  }
}

class _ExecutorServiceSequential extends ExecutorService {
  final List<ExecutorTask> _queue = [];

  ExecutorTask? _executing;

  @override
  Future<R?> execute<R>(ExecutorTask<R> task) async {
    if (_executing != null) {
      var completer = Completer<R>();

      _queue.add(() {
        FutureOr<R?> ret ;
        try {
          ret = task() ;
        } finally {
          if (ret == null) {
            completer.complete(null);
          }
          else if (ret is Future) {
            var future = ret as Future<R?> ;
            future.then((r) => completer.complete(r));
          }
          else {
            var r = ret as R ;
            completer.complete(r);
          }
        }
      });

      return completer.future;
    }

    return _executeWithTask(task);
  }

  Future<R?> _executeWithTask<R>(ExecutorTask<R> task) {
    _executing = task;

    return Future<R?>.microtask(() async {
      try {
        return task();
      } catch (e, s) {
        print(e);
        print(s);
        return null ;
      } finally {
        _executing = null;
        Future.microtask(_executeFromQueue);
      }
    });
  }

  void _executeFromQueue<R>() {
    if (_queue.isEmpty) return null;

    var task = _queue.removeAt(0);
    _executing = task;

    Future.microtask(() {
      try {
        task();
      } catch (e, s) {
        print(e);
        print(s);
      } finally {
        _executing = null;
        Future.microtask(_executeFromQueue);
      }
    });
  }
}

class _ExecutorServiceParallel extends ExecutorService {
  Future<R?> execute<R>(ExecutorTask<R> task) {
    return Future<R?>.microtask(task);
  }
}

class _ExecutorServiceScheduled extends ScheduledExecutorService {
  Future<R?> execute<R>(ExecutorTask<R> task) {
    return Future<R?>.microtask(task);
  }

  @override
  ScheduledFuture<R?> schedule<R>(ExecutorTask<R> task, [Duration? delay]) {
    var scheduledFuture = ScheduledFuture<R?>(delay, task);

    if (delay != null && delay.inMilliseconds > 0) {
      scheduledFuture._future = Future<R?>.delayed(
          delay, scheduledFuture.executeTask);
    } else {
      scheduledFuture._future = Future<R?>.microtask(scheduledFuture.executeTask);
    }

    return scheduledFuture;
  }

}

class ExecutorServices {
  final ExecutorService sequentialIO;

  final ExecutorService parallelIO;

  final ScheduledExecutorService sequentialScheduled;

  ExecutorServices(
      {ExecutorService? sequentialIO,
      ExecutorService? parallelIO,
      ScheduledExecutorService? sequentialScheduled})
      : sequentialIO = sequentialIO ?? ExecutorService.createSequencial(),
        parallelIO = parallelIO ?? ExecutorService.createParallel(),
        sequentialScheduled =
            sequentialScheduled ?? ExecutorService.createScheduled();
}
