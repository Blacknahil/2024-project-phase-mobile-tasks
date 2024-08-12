import 'package:flutter/material.dart';
import 'product.dart';

class ECommerce {
  List<Product> products = [];

  static ECommerce? _instance;
  ECommerce._internal();

  factory ECommerce() {
    if (_instance == null) {
      _instance = ECommerce._internal();
      return _instance!;
    }
    return _instance!;
  }

  bool addProduct(
      {String? name, String? catagory, int? price, String? description}) {
    try {
      final product = Product(
        id: products.length + 1,
        name: name ?? 'Default name',
        catagory: catagory ?? 'Default catagory',
        description: description ?? 'Default description',
        price: price ?? -1,
      );
      products.add(product);
      return true;
    } catch (e) {
      debugPrint('error occured$e');
      return false;
    }
  }

  bool deleteProduct(int id) {
    if (products.every((product) => product.getId != id)) {
      return false;
    }

    products.removeWhere((product) => product.getId == id);
    return true;
  }

  List<Product> getAllProduct() {
    return products;
  }

  Product getProduct(int id) {
    for (var product in products) {
      if (product.getId == id) {
        return product;
      }
    }
    throw Exception('Product not found');
  }

  bool updateProduct(
      {required int id,
      String? name,
      String? catagory,
      int? price,
      String? description}) {
    for (var product in products) {
      if (product.getId == id) {
        if (name != null) {
          product.setName = name;
        }
        if (catagory != null) {
          product.setCatagory = catagory;
        }
        if (price != null) {
          product.setPrice = price;
        }
        if (description != null) {
          product.setDescription = description;
        }

        return true;
      }
    }

    return false;
  }
}
