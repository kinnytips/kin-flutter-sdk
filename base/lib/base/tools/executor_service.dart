import 'dart:async';

typedef Runnable = void Function();

abstract class ExecutorService {
  Future execute(Runnable task);
}

abstract class ScheduledExecutorService extends ExecutorService {
  Future schedule(Runnable task, Duration delay);
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
  Future schedule(Runnable task, Duration delay) {
    return Future.delayed(delay, task);
  }
}

class ExecutorServices {
  static ExecutorService sequentialIO = _ExecutorServiceSequential();

  static ExecutorService parallelIO = _ExecutorServiceParallel();

  static ScheduledExecutorService sequentialScheduled =
      _ExecutorServiceScheduled();
}
