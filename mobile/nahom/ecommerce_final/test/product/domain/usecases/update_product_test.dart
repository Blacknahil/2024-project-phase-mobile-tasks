import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/update_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late UpdateProduct updateProduct;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    updateProduct = UpdateProduct(mockProductRepository);
  });

  const testProduct = ProductEntity(
    catagory: "Man's shoes",
    name: "ambessa shoes",
    description: "a shoe made from the natural tannery of ethiopian cows",
    price: 120,
  );

  test(
    'should update the repository and return the updated entity.',
    () async {
      //arange
      when(mockProductRepository.updateProduct(testProduct))
          .thenAnswer((_) async => const Right(testProduct));
      //act

      final result = await updateProduct.execute(testProduct);

      //assert
      expect(result, const Right(testProduct));
    },
  );
  test(
    'should return a failure when the respository fails to update',
    () async {
      //arange
      when(mockProductRepository.updateProduct(testProduct))
          .thenAnswer((_) async => const Left(ServerFailure('')));
      //act

      final result = await updateProduct.execute(testProduct);

      //assert
      expect(result, const Left(ServerFailure('')));
    },
  );
}
