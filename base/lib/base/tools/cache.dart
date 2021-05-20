import 'package:kin_base/base/tools/executor_service.dart';

class Cache<KEY> {
  final Duration defaultTimeout;

  final ExecutorService executor = ExecutorService.createSequencial();

  final Map<KEY, Pair<dynamic, int>> _storage = <KEY, Pair<dynamic, int>>{};

  Cache({Duration defaultTimeout})
      : defaultTimeout = defaultTimeout ?? Duration(minutes: 5);

  Future<VALUE> resolve<VALUE>(
    KEY key,
    Duration timeoutOverride, [
    Future<VALUE> Function(KEY key) fault,
  ]) async {
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
          return value as VALUE;
        }
      }
    }

    if (fault != null) {
      var resolved = fault(key);
      _storage[key] = Pair(resolved, DateTime.now().millisecondsSinceEpoch);
      return resolved as VALUE;
    }

    return null;
  }

  Future<VALUE> warm<VALUE>(
    KEY key,
    Future<VALUE> Function(KEY key) fault,
  ) async {
    var resolved = fault(key);
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
