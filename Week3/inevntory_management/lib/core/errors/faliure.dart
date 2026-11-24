abstract class Failure {
  String message;
  Failure(this.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure(super.message);
}
