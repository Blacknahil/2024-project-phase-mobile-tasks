import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';
import 'package:ecommerce_task_9/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group(
    "String To unSigned Int",
    () {
      test(
        'should return an integer when the integer represents an unsigned integer',
        () async {
          // Arrange

          // Act
          final str = "123";
          final result = inputConverter.stringToUnSignedInteger(str);

          // Assert
          expect(result, Right(123));
        },
      );

      test(
        'should return a failure when the string is not an integer',
        () async {
          // Arrange

          // Act
          final str = "1.23";
          final result = inputConverter.stringToUnSignedInteger(str);

          // Assert
          expect(result, const Left(InvalidInputFailure("")));
        },
      );
      test(
        'should return a failure for negative integers',
        () async {
          // Arrange

          // Act
          final str = "-123";
          final result = inputConverter.stringToUnSignedInteger(str);

          // Assert
          expect(result, const Left(InvalidInputFailure("")));
        },
      );
    },
  );
}
