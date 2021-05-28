import 'dart:async';

abstract class Disposable<T> {
  void dispose();

  Observer<T> disposedBy(DisposeBag disposeBag);

  Observer<T> doOnDisposed(void Function() onDisposed);
}

class DisposeBag {
  final List<Disposable> _disposables = <Disposable>[];

  void add(Disposable disposable) {
    _disposables.add(disposable);
  }

  void dispose() {
    _disposables.forEach((e) => e.dispose());
  }
}

abstract class Observer<T> extends Disposable<T> {
  Observer<T> add(void Function(T e) listener);

  Observer<T> remove(void Function(T e) listener);

  int listenerCount();

  Observer<T> requestInvalidation();

  Observer<V> map<V>(V Function(T e) function);

  Future<V> mapPromise<V>(V Function(T e) map);

  Future<V> flatMapPromise<V>(Future<V> Function(T e) promise);

  Observer<T> filter(bool Function(T e) function);
}

extension ObserverExtension<T> on Observer<T> {
  Observer<T> listen(ValueListener<T> listener) {
    return add((e) => listener.onNext(e));
  }
}

typedef Callback<T> = void Function(T value, [Error error, StackTrace s]);

class ObservableCallback<T> {
  final void Function(T value) onNext;

  final void Function() onCompleted;
  final void Function(Error error) onError;

  ObservableCallback(
      {this.onNext, this.onCompleted, void Function(Error error) onError})
      : onError = onError ?? ((e) => throw e);
}

abstract class ValueListener<T> {
  void onNext(T value);

  void onError(Error error);
}

extension FutureCallbackExtension<T> on Future<T> {
  void callback(Callback<T> callback) {
    this.then((value) {
      callback(value);
    }, onError: (error, stackStrace) => callback(null, error, stackStrace));
  }
}

abstract class ListOperations<T> {
  ListObserver<T> requestNextPage();

  ListObserver<T> requestPreviousPage();
}

abstract class ListObserver<T> extends Observer<List<T>>
    with ListOperations<T> {
  @override
  ListObserver<T> add(void Function(List<T> e) listener);
}

extension ListObserverExtension<T> on ListObserver<T> {
  ListObserver<T> listen(ValueListener<List<T>> listener) {
    return add((e) => listener.onNext(e));
  }
}

class ValueSubject<T> extends Observer<T> {
  final void Function() _triggerInvalidation;

  ValueSubject([this._triggerInvalidation]);

  final List<void Function(T e)> _listeners = <void Function(T)>[];

  T _currentValue;

  final List<void Function()> _onDisposed = <void Function()>[];

  bool distinctUntilChanged = true;

  @override
  Observer<T> add(void Function(T e) listener) {
    _listeners.add(listener);
    if (_currentValue != null) {
      listener(_currentValue);
    }
    return this;
  }

  void onNext(T newValue) {
    if (distinctUntilChanged && newValue == _currentValue) {
      return;
    }
    _listeners.forEach((listener) => listener(newValue));
    _currentValue = newValue;
  }

  @override
  Observer<T> remove(void Function(T e) listener) {
    _listeners.remove(listener);
    return this;
  }

  @override
  int listenerCount() => _listeners.length;

  dispose() {
    for (var listener in _listeners) {
      remove(listener);
    }
    _onDisposed.forEach((f) => f());
    _onDisposed.clear();
  }

  @override
  Observer<T> disposedBy(DisposeBag disposeBag) {
    disposeBag.add(this);
    return this;
  }

  @override
  Observer<T> requestInvalidation() {
    if (_triggerInvalidation != null) _triggerInvalidation();
    return this;
  }

  @override
  Observer<T> doOnDisposed(void Function() onDisposed) {
    _onDisposed.add(onDisposed);
    return this;
  }

  @override
  Future<V> mapPromise<V>(V Function(T e) map) {
    var completer = Completer<V>();

    add((e) {
      try {
        var o = map(e);
        completer.complete(o);
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });

    return completer.future;
  }

  @override
  Future<V> flatMapPromise<V>(Future<V> Function(T) promise) {
    var completer = Completer<V>();

    add((e) {
      promise(e).then((o) => completer.complete(o),
          onError: (error, stackTrace) =>
              completer.completeError(error, stackTrace));
    });

    return completer.future;
  }

  @override
  Observer<V> map<V>(V Function(T e) function) {
    var valueSubject = ValueSubject<V>();

    add((e) => valueSubject.onNext(function(e)));

    valueSubject.doOnDisposed(() => this.dispose());
    doOnDisposed(() => valueSubject.dispose());

    return valueSubject;
  }

  @override
  Observer<T> filter(bool Function(T e) function) {
    var valueSubject = ValueSubject<T>();

    add((e) {
      if (function(e)) {
        valueSubject.onNext(e);
      }
    });

    valueSubject.doOnDisposed(() => this.dispose());
    doOnDisposed(() => valueSubject.dispose());

    return valueSubject;
  }
}

class ListSubject<T> extends ValueSubject<List<T>> implements ListObserver<T> {
  final void Function() _fetchNextPage;

  final void Function() _fetchPreviousPage;

  ListSubject([this._fetchNextPage, this._fetchPreviousPage,
      void Function() triggerInvalidation])
      : super(triggerInvalidation);

  @override
  ListObserver<T> add(void Function(List<T> e) listener) {
    super.add(listener);
    return this;
  }

  @override
  ListObserver<T> requestNextPage() {
    if (_fetchNextPage != null) {
      _fetchNextPage();
    }
    return this;
  }

  @override
  ListObserver<T> requestPreviousPage() {
    if (_fetchPreviousPage != null) {
      _fetchPreviousPage();
    }
    return this;
  }
}
