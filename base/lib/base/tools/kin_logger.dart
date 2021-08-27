abstract class KinLogger {
  void logByFunction(String Function() msg);

  void log(String msg);

  void warning(String msg);

  void error(String msg, [Error? error, StackTrace? stackTrace]);

  bool? isLoggingEnabled;
}

abstract class KinLoggerFactory {
  bool? isLoggingEnabled;

  KinLogger getLogger(String name);
}

/// Basic logging implementation (prints to console).
class KinLoggerImpl implements KinLogger {
  final String name;

  @override
  bool? isLoggingEnabled;

  KinLoggerImpl(this.name, [bool? isLoggingEnabled])
      : isLoggingEnabled = isLoggingEnabled ?? true ;

  @override
  void error(String msg, [Error? error, StackTrace? stackTrace]) {
    if (!isLoggingEnabled!) return;
    print('[ERROR] $name> $msg');
    if (error != null) print(error);
    if (stackTrace != null) print(stackTrace);
  }

  @override
  void log(String msg) {
    if (!isLoggingEnabled!) return;
    print('[INFO] $name> $msg');
  }

  @override
  void logByFunction(String Function() msg) {
    log(msg());
  }

  @override
  void warning(String msg) {
    if (!isLoggingEnabled!) return;
    print('[WARN] $name> $msg');
  }
}

class KinLoggerFactoryImpl implements KinLoggerFactory {
  @override
  bool? isLoggingEnabled;

  KinLoggerFactoryImpl([this.isLoggingEnabled = false]);

  @override
  KinLogger getLogger(String name) {
    return KinLoggerImpl(name, isLoggingEnabled);
  }
}
