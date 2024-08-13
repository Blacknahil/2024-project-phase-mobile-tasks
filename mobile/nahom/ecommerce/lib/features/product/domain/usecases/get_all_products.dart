import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';

import '../../../../core/error/failure.dart';
import 'base_usecase.dart';

class GetAllProducts extends UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository productRepository;

  GetAllProducts(this.productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> execute(NoParams params) {
    return productRepository.getAllProducts();
  }
}

class NoParams {}
