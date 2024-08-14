import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/add_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late AddProduct addProduct;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    addProduct = AddProduct(mockProductRepository);
  });

  const testNewProduct = ProductEntity(
    name: "ambessa shoes",
    description: "a shoe made from the natural tannery of ethiopian cows",
    price: 120,
  );

  test(
    'should add new product to the repository and return the created entity.',
    () async {
      //arange
      when(mockProductRepository.addProduct(testNewProduct))
          .thenAnswer((_) async => const Right(testNewProduct));
      //act

      final result = await addProduct.execute(testNewProduct);

      //assert
      expect(result, const Right(testNewProduct));
    },
  );

  test(
    'should return a Failure when the repository fails',
    () async {
      //arange
      when(mockProductRepository.addProduct(testNewProduct))
          .thenAnswer((_) async => const Left(NetworkFailure("")));
      //act

      final result = await addProduct.execute(testNewProduct);

      //assert
      expect(result, const Left(NetworkFailure("")));
    },
  );
}
