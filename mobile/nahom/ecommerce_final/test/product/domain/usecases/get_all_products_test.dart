import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/get_all_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetAllProducts getAllProducts;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getAllProducts = GetAllProducts(mockProductRepository);
  });

  const testNewProduct = ProductEntity(
    name: "ambessa shoes",
    description: "a shoe made from the natural tannery of ethiopian cows",
    price: 120,
  );
  const testProductList = [testNewProduct];

  test(
    "should return a list of all prodcuts",
    () async {
      //arrange

      when(
        (mockProductRepository.getAllProducts()),
      ).thenAnswer((_) async {
        return const Right(testProductList);
      });
      //act
      final result = await getAllProducts.execute(NoParams());
      //assert

      expect(result, const Right(testProductList));
      verify(mockProductRepository.getAllProducts());
    },
  );

  test(
    "should return a failure when the server fails",
    () async {
      //arrange

      when(
        (mockProductRepository.getAllProducts()),
      ).thenAnswer((_) async {
        return const Left(ServerFailure(''));
      });
      //act
      final result = await getAllProducts.execute(NoParams());
      //assert

      expect(result, const Left(ServerFailure('')));
      verify(mockProductRepository.getAllProducts());
    },
  );
}
