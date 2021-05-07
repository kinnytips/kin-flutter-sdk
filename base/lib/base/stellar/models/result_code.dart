class ResultCode {
  final int value;
  ResultCode(this.value);
}

class Success extends ResultCode {
  Success(): super(0);
}

class Failed extends ResultCode {
  Failed(): super(-1);
}

class TooEarly extends ResultCode {
  TooEarly(): super(-2);
}

class TooLate extends ResultCode {
    TooLate(): super(-3);
}

class MissingOperation extends ResultCode {
    MissingOperation(): super(-4);
}

class BadSequenceNumber extends ResultCode {
    BadSequenceNumber(): super(-5);
}

class BadAuth extends ResultCode {
    BadAuth(): super(-6);
}

class InsufficientBalance extends ResultCode {
    InsufficientBalance(): super(-7);
}

class NoAccount extends ResultCode {
    NoAccount(): super(-8);
}

class InsufficientFee extends ResultCode {
    InsufficientFee(): super(-9);
}

class BadAuthExtra extends ResultCode {
    BadAuthExtra(): super(-10);
}

class InternalError extends ResultCode {
    InternalError(): super(-11);
}
