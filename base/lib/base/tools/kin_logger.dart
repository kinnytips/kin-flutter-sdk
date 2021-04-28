abstract class KinLogger {
  void logByFunction(String Function() msg);

  void log(String msg);

  void warning(String msg);

  void error(String msg, [Error throwable]);

  bool isLoggingEnabled;
}

abstract class KinLoggerFactory {
  bool isLoggingEnabled;

  KinLogger getLogger(String name);
}
