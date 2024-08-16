import 'dart:convert';

import 'package:ecommerce_task_9/features/product/data/models/product_model.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testProductModel = ProductModel(
    name: "ambessa shoes",
    description: "a shoe made from the natural tannery of ethiopian cows",
    price: 120,
    id: "1",
    imageUrl: "images/home.png",
  );

  test(
    "Produt model should be a subclass of product entity",
    () async {
      //arraneg
      //act
      //assert
      expect(testProductModel, isA<ProductEntity>());
    },
  );

  test(
    "Should return a valid model from json",
    () async {
      //arrange
      final Map<String, dynamic> jsonMap = jsonDecode(
        fixture('product.json'),
      );
      //act
      final result = ProductModel.fromJson(jsonMap);
      //assert
      expect(result, isA<ProductModel>());
      expect(result, testProductModel);
    },
  );

  test(
    "Should return json map containing valid map",
    () async {
      //arrange
      final result = testProductModel.toJson();
      final expectedJson = {
        "name": "ambessa shoes",
        "description": "a shoe made from the natural tannery of ethiopian cows",
        "price": 120,
        "id": "1",
        "imageUrl": "images/home.png"
      };
      //act
      //assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result, expectedJson);
    },
  );
}
