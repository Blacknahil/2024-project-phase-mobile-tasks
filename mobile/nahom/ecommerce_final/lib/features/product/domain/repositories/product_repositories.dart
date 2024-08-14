import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';

import '../../../../core/error/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> getSpecificProduct(int id);
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, Unit>> deleteProduct(int id);
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product);
  Future<Either<Failure, ProductEntity>> addProduct(ProductEntity product);
}
