abstract class AppExceptions implements Exception {
  final String message;
  final Object? orignalError;
  final StackTrace? stackTrace;

  AppExceptions({required this.message, this.orignalError, this.stackTrace});
}

class NetworkException extends AppExceptions {
  NetworkException({
    required super.message,
    super.orignalError,
    super.stackTrace,
  });
}

class DataBaseException extends AppExceptions {
  DataBaseException({
    required super.message,
    super.orignalError,
    super.stackTrace,
  });
}

class UnexpectedExeption extends AppExceptions {
  UnexpectedExeption({
    required super.message,
    super.orignalError,
    super.stackTrace,
  });
}
