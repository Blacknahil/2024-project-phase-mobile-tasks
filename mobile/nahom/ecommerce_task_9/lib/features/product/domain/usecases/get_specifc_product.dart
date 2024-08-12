import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';

import '../../../../core/error/failure.dart';

class GetSpecificProduct {
  final ProductRepository productRepository;

  GetSpecificProduct(this.productRepository);

  Future<Either<Failure, ProductEntity>> execute(int id) {
    return productRepository.getSpecificProduct(id);
  }
}
