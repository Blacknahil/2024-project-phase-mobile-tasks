import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/get_specifc_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetSpecificProduct getSpecificProduct;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getSpecificProduct = GetSpecificProduct(mockProductRepository);
  });

  const testId = "92hui";

  const testProduct = ProductEntity(
    name: "ambessa shoes",
    description: "a shoe made from the natural tannery of ethiopian cows",
    price: 120,
  );

  test(
    "should get one specific product",
    () async {
      //arrange
      when(mockProductRepository.getSpecificProduct(any)).thenAnswer((_) async {
        return const Right(testProduct);
      });

      //act
      final result = await getSpecificProduct.execute(testId);

      //assert
      expect(result, const Right(testProduct));
      verify(mockProductRepository.getSpecificProduct(testId));
    },
  );

  test(
    "should return a failure when the repository fails",
    () async {
      //arrange
      when(mockProductRepository.getSpecificProduct(any)).thenAnswer((_) async {
        return const Left(ServerFailure(''));
      });

      //act
      final result = await getSpecificProduct.execute(testId);

      //assert
      expect(result, const Left(ServerFailure('')));
      verify(mockProductRepository.getSpecificProduct(testId));
    },
  );
}
