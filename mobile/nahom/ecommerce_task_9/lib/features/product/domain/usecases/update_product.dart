import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';

class UpdateProduct {
  final ProductRepository productRepository;

  UpdateProduct(this.productRepository);

  Future<Either<Failure, ProductEntity>> execute(ProductEntity product) {
    return productRepository.updateProduct(product);
  }
}
