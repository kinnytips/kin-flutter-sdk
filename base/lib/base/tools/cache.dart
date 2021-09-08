import 'dart:async';

import 'package:kin_base/base/tools/executor_service.dart';

class Cache<KEY> {
  final Duration defaultTimeout;

  final ExecutorService executor = ExecutorService.createSequencial();

  final Map<KEY, Pair<dynamic, int>> _storage = <KEY, Pair<dynamic, int>>{};

  Cache({Duration? defaultTimeout})
      : defaultTimeout = defaultTimeout ?? Duration(minutes: 5);

  FutureOr<V?> resolve<V>(
    KEY key,
      { Duration? timeoutOverride,
        Future<V> Function(KEY key)? fault,
      }) async {
    var now = DateTime.now().millisecondsSinceEpoch;

    var cached = _storage[key];
    if (cached != null) {
      var value = cached.first;

      if (value != null) {
        var timeStored = cached.second;
        var timeToExpiry =
            (timeoutOverride != null) ? timeoutOverride : defaultTimeout;
        var expiryTime = timeStored + timeToExpiry.inMilliseconds;

        if (expiryTime > now) {
          return value as V;
        }
      }
    }

    if (fault != null) {
      var resolvedFuture = fault(key);
      var resolved = await resolvedFuture ;
      _storage[key] = Pair(resolved, DateTime.now().millisecondsSinceEpoch);
      return resolved ;
    }

    return null;
  }

  FutureOr<V?> warm<V>(
    KEY key,
    FutureOr<V> Function(KEY key) fault,
  ) async {
    var resolvedFuture = fault(key);
    var resolved = resolvedFuture != null ? await resolvedFuture : null ;
    _storage[key] = Pair(resolved, DateTime.now().millisecondsSinceEpoch);
    return resolved;
  }

  void invalidate(KEY key) {
    _storage.remove(key);
  }
}

class Pair<A, B> {
  final A first;
  final B second;

  Pair(this.first, this.second);

  String toString() => "($first, $second)";
}
