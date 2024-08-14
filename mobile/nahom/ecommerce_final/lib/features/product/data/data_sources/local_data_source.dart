import 'dart:convert';

import 'package:ecommerce_task_9/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

abstract class LocalDataSource {
  /// Gets the cached [Product] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<ProductModel> getSpecificProduct(int id);

  /// Gets the cached [Products] which was gotten the last time
  ///the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<ProductModel>> getAllProducts();

  Future<void> cacheAllProducts(List<ProductModel> products);
}

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAllProducts(List<ProductModel> products) async {
    //convert each prodcut model to json and store it as a List of jsons
    List<Map<String, dynamic>> jsonList = products.map((product) {
      return product.toJson();
    }).toList();

    // covert the list of json strings to one big JSON String

    String jsonString = json.encode(jsonList);

    //save the json string to shared preferences
    await sharedPreferences.setString(CACHED_PRODUCTS, jsonString);
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      //get the cached string from shared prefrences
      final productsString = sharedPreferences.getString(CACHED_PRODUCTS);
      //check if it is not null
      if (productsString != null) {
        //decode the json string into a list of dynamic object
        final List<dynamic> decodedJsonList = json.decode(productsString);

        //Convert each JSON item into a ProductModel object
        final List<ProductModel> productList = decodedJsonList.map((jsonItem) {
          return ProductModel.fromJson(jsonItem);
        }).toList();

        return Future.value(productList);
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> getSpecificProduct(int id) async {
    try {
      final ProductsString = sharedPreferences.getString(CACHED_PRODUCTS);
      if (ProductsString != null) {
        //decode the json string into a list of dynamic object
        final List<dynamic> decodedJsonList = json.decode(ProductsString);

        //Convert each JSON item into a ProductModel object
        final List<ProductModel> productsList = decodedJsonList
            .map((jsonItem) => ProductModel.fromJson(jsonItem))
            .toList();

        //find product with the specified id
        final product = productsList.firstWhere((product) => product.id == id,
            orElse: () => throw (CacheException()));

        return product;
      } else {
        throw (CacheException());
      }
    } catch (e) {
      throw (CacheException());
    }
  }
}
