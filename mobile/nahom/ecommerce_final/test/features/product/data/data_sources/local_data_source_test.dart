import 'dart:convert';

import 'package:ecommerce_task_9/core/error/exception.dart';
import 'package:ecommerce_task_9/features/product/data/data_sources/local_data_source.dart';
import 'package:ecommerce_task_9/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late LocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(
    () {
      mockSharedPreferences = MockSharedPreferences();
      dataSource =
          LocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
    },
  );

  group(
    "\n Get All Prodcuts from cache\n",
    () {
      final jsonString = fixture('cached_products.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      final testProductsModelList = ProductModel.fromJsonList(jsonList);
      const CACHED_PRODUCTS = "CACHED_PRODUCTS";
      test(
          'should return cached products from shared reference when there is one in the cache',
          () async {
        //arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(json.encode(jsonList));

        //act
        final result = await dataSource.getAllProducts();

        //assert
        verify(mockSharedPreferences.getString(CACHED_PRODUCTS));
        expect(result, equals(testProductsModelList));
      });

      test('should return chache failure when there is no chached value',
          () async {
        //arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);

        //act
        final call = await dataSource.getAllProducts;

        //assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      });
    },
  );

  group('cacheAllProducts', () {
    final List<ProductModel> testProducts = [
      const ProductModel(
        id: '1',
        name: 'Product 1',
        price: 100,
        description: 'mens shoe',
        imageUrl: "url",
      ),
    ];

    test(
        'should convert the product list to JSON and save it to SharedPreferences',
        () async {
      // Arrange
      final List<Map<String, dynamic>> jsonList =
          testProducts.map((product) => product.toJson()).toList();
      final String jsonString = json.encode(jsonList);
      const CACHED_PRODUCTS = "CACHED_PRODUCTS";

      when(mockSharedPreferences.setString(CACHED_PRODUCTS, jsonString))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.cacheAllProducts(testProducts);

      // Assert
      verify(mockSharedPreferences.setString(CACHED_PRODUCTS, jsonString))
          .called(1);
    });
  });

  group(
    "Get Specific Product",
    () {
      final jsonString = fixture('cached_products.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      final testProductModelList = ProductModel.fromJsonList(jsonList);

      const CACHED_PRODUCTS = "CACHED_PRODUCTS";
      const testId = "1";

      test(
        "should return one product that has been chached by id",
        () async {
          //arrange
          when(mockSharedPreferences.getString(any))
              .thenReturn(json.encode(jsonList));

          //act
          final result = await dataSource.getSpecificProduct(testId);
          verify(mockSharedPreferences.getString(CACHED_PRODUCTS));
          expect(result, testProductModelList.first);

          //assert
        },
      );

      test("should throw a chache exception when the product is not found",
          () async {
        //arrange
        when(mockSharedPreferences.getString(CACHED_PRODUCTS))
            .thenReturn(json.encode(jsonList));

        //act
        final call = dataSource.getSpecificProduct("3");

        //assert
        expect(() => call, throwsA(TypeMatcher<CacheException>()));
      });

      test("should throw a chache exception Nothing has been cached", () async {
        //arrange
        when(mockSharedPreferences.getString(CACHED_PRODUCTS)).thenReturn(null);

        //act
        final call = dataSource.getSpecificProduct(testId);

        //assert
        expect(() => call, throwsA(TypeMatcher<CacheException>()));
      });

      test("should throw a chache exception Nothing has been cached", () async {
        //arrange
        when(mockSharedPreferences.getString(CACHED_PRODUCTS))
            .thenReturn('Invalid Json');

        //act
        final call = dataSource.getSpecificProduct(testId);

        //assert
        expect(() => call, throwsA(TypeMatcher<CacheException>()));
      });
    },
  );
}
