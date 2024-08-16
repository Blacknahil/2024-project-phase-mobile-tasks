import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/base_usecase.dart';

import '../../../../core/error/failure.dart';

class DeleteProduct extends UseCase<Unit, String> {
  final ProductRepository productRepository;
  DeleteProduct(this.productRepository);

  @override
  Future<Either<Failure, Unit>> execute(String id) {
    return productRepository.deleteProduct(id);
  }
}
