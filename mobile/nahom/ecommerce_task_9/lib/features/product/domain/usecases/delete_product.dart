import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';

import '../../../../core/error/failure.dart';

class DeleteProduct {
  final ProductRepository productRepository;
  DeleteProduct(this.productRepository);

  Future<Either<Failure, Unit>> execute(int id) {
    return productRepository.deleteProduct(id);
  }
}
