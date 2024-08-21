import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/exception.dart';
import 'package:ecommerce_task_9/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

const URL = "https://g5-flutter-learning-path-be.onrender.com/api/v1/products";

abstract class RemoteDataSource {
  ///calls the backend server to perform crud operations
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> getSpecificProduct(String id);

  ///calls the backend server to perform crud operations
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> getAllProducts();

  ///calls the backend server to perform crud operations
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Unit> deleteProduct(String id);

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
  Future<ProductModel> addProduct(ProductModel product) async {
    var request = http.MultipartRequest('POST', Uri.parse(URL));

    request.fields['name'] = product.name;
    request.fields['description'] = product.description;
    request.fields['price'] = product.price.toString();
    try {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          product.imageUrl,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    } catch (e) {
      throw ImageUploadException();
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      var responseData = await response.stream.bytesToString();
      return ProductModel.fromJson(json.decode(responseData)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteProduct(String id) async {
    try {
      final response = await client.delete(Uri.parse('$URL/$id'));
      if (response.statusCode == 200) {
        return unit;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await client
          .get(Uri.parse(URL), headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        try {
          final responseBody = response.body;
          final decodedResponseBody = json.decode(responseBody);
          final productsJson = decodedResponseBody["data"] as List;
          final products = productsJson
              .map((productJson) => ProductModel.fromJson(productJson))
              .toList();
          return products;
        } catch (e) {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getSpecificProduct(String id) async {
    try {
      final response = await client.get(
        Uri.parse('$URL/$id'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        try {
          final data = response.body;
          final decodedData = json.decode(data);
          final productJson = decodedData["data"];
          return ProductModel.fromJson(productJson);
        } catch (e) {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final productId = product.id;
    final jsonBody = jsonEncode(product.toJson());

    try {
      final response = await client.put(Uri.parse('$URL/$productId'),
          body: jsonBody, headers: {"Content-Type": "application/json"});

      print(response.statusCode);
      print('$URL/$productId');
      if (response.statusCode == 200) {
        return ProductModel.fromJson(json.decode(response.body)["data"]);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
