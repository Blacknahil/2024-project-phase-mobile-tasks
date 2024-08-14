import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  ///calls the backend server to perform crud operations
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> getSpecificProduct(int id);

  ///calls the backend server to perform crud operations
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> getAllProducts();

  ///calls the backend server to perform crud operations
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Unit> deleteProduct(int id);

  ///calls the backend server to perform crud operations
  ///
  ///Throws a [ServerException] for all error codes.
  Future<ProductModel> updateProduct(ProductModel product);

  ///calls the backend server to perform crud operations
  ///
  ///Throws a [ServerException] for all error codes.
  Future<ProductModel> addProduct(ProductModel product);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> addProduct(ProductModel product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<Unit> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> getSpecificProduct(int id) {
    // TODO: implement getSpecificProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
