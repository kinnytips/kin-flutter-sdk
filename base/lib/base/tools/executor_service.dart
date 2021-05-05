import 'dart:async';

typedef Runnable = void Function();

abstract class ExecutorService {
  static ExecutorService createSequencial() => _ExecutorServiceSequential() ;
  static ExecutorService createParallel() => _ExecutorServiceParallel();
  static ScheduledExecutorService createScheduled() => ScheduledExecutorService.create();

  Future execute(Runnable task);
}

abstract class ScheduledExecutorService extends ExecutorService {
  static ScheduledExecutorService create() => _ExecutorServiceScheduled();

  ScheduledFuture schedule(Runnable task, Duration delay);
}

class ScheduledFuture<T> {
  final Duration delay;
  Runnable _task;

  Future<T> _future;

  Future<T> get future => _future;

  ScheduledFuture(this.delay, this._task);

  void executeTask() {
    if (_task == null) return;
    _task();
    _task = null;
  }

  void cancel() {
    _task = null;
  }
}

class _ExecutorServiceSequential extends ExecutorService {
  final List<Runnable> _queue = [];

  Runnable _executing;

  @override
  Future execute(Runnable task) {
    if (_executing != null) {
      var completer = Completer();
      _queue.add(() {
        try {
          task();
        } finally {
          completer.complete();
        }
      });
      return completer.future;
    }

    return _execute(task);
  }

  Future _execute([Runnable task]) {
    if (task == null) {
      if (_queue.isEmpty) return null;
      task = _queue.removeAt(0);
    }

    _executing = task;

    return Future.microtask(() {
      try {
        task();
      } catch (e, s) {
        print(e);
        print(s);
      } finally {
        _executing = null;
        _execute();
      }
    });
  }
}

class _ExecutorServiceParallel extends ExecutorService {
  Future execute(void Function() task) {
    return Future.microtask(task);
  }
}

class _ExecutorServiceScheduled extends ScheduledExecutorService {
  Future execute(void Function() task) {
    return Future.microtask(task);
  }

  @override
  ScheduledFuture schedule(Runnable task, Duration delay) {
     var scheduledFuture = ScheduledFuture(delay, task) ;
     scheduledFuture._future = Future.delayed(delay, scheduledFuture.executeTask);
    return scheduledFuture ;
  }
}

class ExecutorServices {
  static ExecutorService sequentialIO = ExecutorService.createSequencial();

  static ExecutorService parallelIO = ExecutorService.createParallel();

  static ScheduledExecutorService sequentialScheduled =
      ExecutorService.createScheduled();
}
