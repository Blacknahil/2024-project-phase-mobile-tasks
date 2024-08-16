import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/base_usecase.dart';

import '../../../../core/error/failure.dart';

class GetSpecificProduct extends UseCase<ProductEntity, String> {
  final ProductRepository productRepository;

  GetSpecificProduct(this.productRepository);

  @override
  Future<Either<Failure, ProductEntity>> execute(String id) {
    return productRepository.getSpecificProduct(id);
  }
}
