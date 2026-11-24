import 'package:inevntory_management/core/errors/app_exceptions.dart';
import 'package:inevntory_management/core/errors/faliure.dart';

class ErrorMapper {
  static Failure map(Object error) {
    if (error is NetworkException) {
      return NetworkFailure("Please check your internet connection");
    }
    if (error is DataBaseException) {
      return DatabaseFailure("Failed to access database");
    }

    return UnexpectedFailure("Unexpected error occurs");
  }
}
