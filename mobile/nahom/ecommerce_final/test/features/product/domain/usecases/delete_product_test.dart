import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late DeleteProduct deleteProduct;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProduct = DeleteProduct(mockProductRepository);
  });

  const testId = "981";

  test(
    "should delete a product from the repository",
    () async {
      //arrange
      when(mockProductRepository.deleteProduct(any)).thenAnswer((_) async {
        return const Right(unit);
      });

      //act
      final result = await deleteProduct.execute(testId);

      //assert
      expect(result, const Right(unit));
      verify(mockProductRepository.deleteProduct(testId));
    },
  );

  test(
    "should return a failure when the repository fails",
    () async {
      //arrange
      when(mockProductRepository.deleteProduct(any)).thenAnswer((_) async {
        return const Left(ServerFailure(""));
      });

      //act
      final result = await deleteProduct.execute(testId);

      //assert
      expect(result, const Left(ServerFailure('')));
      verify(mockProductRepository.deleteProduct(testId));
    },
  );
}
