import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';

import '../../../../core/error/failure.dart';

class GetAllProducts {
  final ProductRepository productRepository;

  GetAllProducts(this.productRepository);

  Future<Either<Failure, List<ProductEntity>>> execute() {
    return productRepository.getAllProducts();
  }
}
