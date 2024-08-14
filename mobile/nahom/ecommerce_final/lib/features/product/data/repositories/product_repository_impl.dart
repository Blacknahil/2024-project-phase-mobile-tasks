import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/exception.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';
import 'package:ecommerce_task_9/features/product/data/models/product_model.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/network_info.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class ProductRepositoryImpl extends ProductRepository {
  final NetworkInfo networkInfo;
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  ProductRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ProductEntity>> addProduct(
      ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final ProductModel productModel = ProductModel.fromEntity(product);
        final result = await remoteDataSource.addProduct(productModel);
        final resultEntity = result.toEntity();
        return Right(resultEntity);
      } catch (e) {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(NetworkFailure(''));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.deleteProduct(id);
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(NetworkFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        localDataSource.cacheAllProducts(remoteProducts);
        final List<ProductEntity> productEntities = remoteProducts;
        return Right(productEntities);
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getAllProducts();
        final List<ProductEntity> productEntities = result;
        return Right(productEntities);
      } on CacheException {
        return const Left(CacheFailure(''));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getSpecificProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getSpecificProduct(id);
        return Right(remoteProduct.toEntity());
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getSpecificProduct(id);
        final ProductEntity resultEntity = result.toEntity();
        return Right(resultEntity);
      } catch (e) {
        return const Left(CacheFailure(''));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
      ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final ProductModel productModel = ProductModel.fromEntity(product);
        debugPrint("to model conversion success");
        final remoteProduct =
            await remoteDataSource.updateProduct(productModel);
        debugPrint("remote data source connection success");
        return Right(remoteProduct.toEntity());
      } on ServerException {
        debugPrint("Server error online");
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(NetworkFailure(''));
    }
  }
}
