import 'dart:async';

typedef ExecutorTask<R> = R Function();

abstract class ExecutorService {
  static ExecutorService createSequencial() => _ExecutorServiceSequential() ;
  static ExecutorService createParallel() => _ExecutorServiceParallel();
  static ScheduledExecutorService createScheduled() => ScheduledExecutorService.create();

  Future<R> execute<R>(ExecutorTask<R> task);
}

abstract class ScheduledExecutorService extends ExecutorService {
  static ScheduledExecutorService create() => _ExecutorServiceScheduled();

  ScheduledFuture<R> schedule<R>(ExecutorTask<R> task, Duration delay);
}

class ScheduledFuture<T> {
  final Duration delay;
  ExecutorTask<T> _task;

  Future<T> _future;

  Future<T> get future => _future;

  ScheduledFuture(this.delay, this._task);

  T executeTask() {
    if (_task == null) return null ;
    var ret = _task();
    _task = null;
    return ret ;
  }

  void cancel() {
    _task = null;
  }
}

class _ExecutorServiceSequential extends ExecutorService {
  final List<ExecutorTask> _queue = [];

  ExecutorTask _executing;

  @override
  Future<R> execute<R>(ExecutorTask<R> task) {
    if (_executing != null) {
      var completer = Completer<R>();
      _queue.add(() {
        R ret ;
        try {
          ret = task();
        } finally {
          completer.complete(ret);
        }
      });
      return completer.future;
    }

    return _execute(task);
  }

  Future<R> _execute<R>([ExecutorTask<R> task]) {
    if (task == null) {
      if (_queue.isEmpty) return null;
      task = _queue.removeAt(0);
    }

    _executing = task;

    return Future<R>.microtask(() {
      try {
        return task();
      } catch (e, s) {
        print(e);
        print(s);
        return null ;
      } finally {
        _executing = null;
        _execute();
      }
    });
  }
}

class _ExecutorServiceParallel extends ExecutorService {
  Future<R> execute<R>(ExecutorTask<R> task) {
    return Future.microtask(task);
  }
}

class _ExecutorServiceScheduled extends ScheduledExecutorService {
  Future<R> execute<R>(ExecutorTask<R> task) {
    return Future<R>.microtask(task);
  }

  @override
  ScheduledFuture<R> schedule<R>(ExecutorTask<R> task, Duration delay) {
     var scheduledFuture = ScheduledFuture<R>(delay, task) ;
     scheduledFuture._future = Future<R>.delayed(delay, scheduledFuture.executeTask);
    return scheduledFuture ;
  }
}

class ExecutorServices {
  final ExecutorService sequentialIO;

  final ExecutorService parallelIO;

  final ScheduledExecutorService sequentialScheduled;

  ExecutorServices(
      {ExecutorService sequentialIO,
      ExecutorService parallelIO,
      ScheduledExecutorService sequentialScheduled})
      : sequentialIO = sequentialIO ?? ExecutorService.createSequencial(),
        parallelIO = parallelIO ?? ExecutorService.createParallel(),
        sequentialScheduled =
            sequentialScheduled ?? ExecutorService.createScheduled();
}
