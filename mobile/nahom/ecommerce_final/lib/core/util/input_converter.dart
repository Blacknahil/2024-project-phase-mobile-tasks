import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnSignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) {
        throw const FormatException();
      }
      return Right(int.parse(str));
    } on FormatException {
      return const Left(InvalidInputFailure(""));
    }
  }
}
