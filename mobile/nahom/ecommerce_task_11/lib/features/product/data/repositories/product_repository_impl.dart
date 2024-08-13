import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';

import '../../../../core/platform/network_info.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';

class ProductRepositoryImpl extends ProductRepository {
  final NetworkInfo networkInfo;
  final ProductLocalDataSource productLocalDataSource;
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl({
    required this.networkInfo,
    required this.productLocalDataSource,
    required this.productRemoteDataSource,
  });

  @override
  Future<Either<Failure, ProductEntity>> addProduct(ProductEntity product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductEntity>> getSpecificProduct(int id) {
    // TODO: implement getSpecificProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
