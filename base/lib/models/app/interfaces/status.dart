class Status {
  final Result result;
  final String message;

  const Status(this.result, this.message);
}

enum Result { SUCCESS, FAIL, UNKNOWN }
