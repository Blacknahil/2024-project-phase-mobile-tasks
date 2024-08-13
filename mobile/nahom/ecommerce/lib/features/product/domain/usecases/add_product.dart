import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/base_usecase.dart';

class AddProduct extends UseCase<ProductEntity, ProductEntity> {
  final ProductRepository productRepository;

  AddProduct(this.productRepository);
  @override
  Future<Either<Failure, ProductEntity>> execute(ProductEntity product) {
    return productRepository.addProduct(product);
  }
}
