/// Analogue of `Either` class from dartz package
/// BUT with better naming and left-handed success result placement
/// Also, right-hand result is always throwable
abstract class Result<A, B extends Exception> {
  bool isSuccess() {
    return this is Success<A, B>;
  }

  A successResult() {
    return (this as Success<A, B>).value;
  }

  A? get successOrNull {
    return isSuccess() ? successResult() : null;
  }

  bool isError() {
    return this is Error<A, B>;
  }

  B errorResult() {
    return (this as Error<A, B>).error;
  }
}

class Success<A, B extends Exception> extends Result<A, B> {
  final A _value;

  A get value => _value;

  Success(this._value);
}

class Error<A, B extends Exception> extends Result<A, B> {
  final B _error;

  B get error => _error;

  Error(this._error);
}
