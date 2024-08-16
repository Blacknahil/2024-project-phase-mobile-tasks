import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/exception.dart';
import 'package:ecommerce_task_9/features/product/data/data_sources/remote_data_source.dart';
import 'package:ecommerce_task_9/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixture_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late MockMultipartFile mockMultipartFile;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
    mockMultipartFile = MockMultipartFile();
  });
  const URL =
      "https://g5-flutter-learning-path-be.onrender.com/api/v1/products";

  group(
    "\n Get Specific Products \n ",
    () {
      final dataString = fixture("actual_product.json");
      final decodedString = json.decode(dataString);
      final testProductModel = ProductModel.fromJson(decodedString['data']);
      const testId = "66bdfad79bbe07fc3903515b";

      test(
        "should perform Get request on a URL with id being the end point with application/json header",
        () async {
          //arrange
          when(mockHttpClient.get(any, headers: anyNamed('headers')))
              .thenAnswer((_) async =>
                  http.Response(fixture('actual_product.json'), 200));
          // act
          final result = await dataSource.getSpecificProduct(testId);
          //assert

          verify(
            mockHttpClient.get(
              Uri.parse('$URL/$testId'),
              headers: {'Content-Type': 'application/json'},
            ),
          );
          expect(result, equals(testProductModel));
        },
      );

      test(
          'should throw a Server excetption error for invalid data when decoding',
          () async {
        // Arrange
        when(mockHttpClient.get(
          Uri.parse('$URL/$testId'),
          headers: {"Content-Type": "application/json"},
        )).thenAnswer((_) async => http.Response(decodedString, 200));

        // Act
        final call = await dataSource.getSpecificProduct;

        // Assert
        expect(
            () => call(testId), throwsA(const TypeMatcher<ServerException>()));
      });

      test(
        "should throw a server exception for 404 or other invaid status codes",
        () async {
          //arrange
          when(mockHttpClient.get(
            Uri.parse('$URL/$testId'),
            headers: {"Content-Type": "application/json"},
          )).thenAnswer((_) async {
            return http.Response("something went wrong", 404);
          });

          //act
          final call = dataSource.getSpecificProduct;
          //assert
          expect(() => call(testId),
              throwsA(const TypeMatcher<ServerException>()));
        },
      );
    },
  );

  group("\n Get All Products", () {
    final dataString = fixture('actual_products.json');
    final decodedString = json.decode(dataString);
    final productsString = decodedString["data"] as List;
    final productsList = productsString
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();
    test(
      "should perform a Get request and return a list of product models",
      () async {
        //arrange
        when(mockHttpClient.get(
          Uri.parse(URL),
          headers: {"Content-Type": "application/json"},
        )).thenAnswer((_) async {
          return http.Response(fixture('actual_products.json'), 200);
        });
        //act
        final result = await dataSource.getAllProducts();
        //assert

        verify(mockHttpClient.get(
          Uri.parse(URL),
          headers: {"Content-Type": "application/json"},
        ));
        expect(result, productsList);
      },
    );

    test(
      "should throw a server exception when the response code is 404 or other",
      () async {
        //arrange
        when(mockHttpClient.get(
          Uri.parse(URL),
          headers: {"Content-Type": "application/json"},
        )).thenAnswer((_) async {
          return http.Response("something went wrong", 404);
        });

        //act
        final call = dataSource.getAllProducts;
        //assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );

    test(
      "should perform a Get request and throw a server cache error when decoding",
      () async {
        //arrange
        when(mockHttpClient.get(
          Uri.parse(URL),
          headers: {"Content-Type": "application/json"},
        )).thenAnswer((_) async {
          return http.Response(decodedString, 200);
        });

        //act
        final call = dataSource.getAllProducts;
        //assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group(
    "\n Update a prodcut \n",
    () {
      final dataString = fixture("updated_product.json");
      final decodedString = json.decode(dataString);
      final testProductModel = ProductModel.fromJson(decodedString['data']);
      const testId = "66bdfad79bbe07fc3903515b";

      test(
        "should call the api with id in the url and body",
        () async {
          //arrange
          when(mockHttpClient.put(
            Uri.parse('$URL/$testId'),
            headers: {'Content-Type': 'application/json'},
            body: anyNamed('body'),
          )).thenAnswer(
              (_) async => http.Response(fixture('updated_product.json'), 200));

          //act
          final result = await dataSource.updateProduct(testProductModel);

          // assert
          verify(mockHttpClient.put(
            Uri.parse('$URL/$testId'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(testProductModel.toJson()),
          ));
          // print("Expected result: $testProductModel");
          expect(result, equals(testProductModel));
        },
      );

      test('should call the API with the correct URL, headers, and body',
          () async {
        // Arrange
        when(mockHttpClient.put(
          Uri.parse('$URL/$testId'),
          headers: {'Content-Type': 'application/json'},
          body: anyNamed('body'),
        )).thenAnswer(
            (_) async => http.Response(fixture('updated_product.json'), 404));

        // Act
        final call = dataSource.updateProduct;

        // Assert

        expect(() => call(testProductModel),
            throwsA(const TypeMatcher<ServerException>()));
      });
    },
  );

  // group(
  //   "\n add Product \n",
  //   () {
  //     const testProductModel = ProductModel(
  //       name: 'Test Product',
  //       description: 'This is a test product',
  //       price: 19,
  //       imageUrl: 'path/to/image.jpg',
  //     );

  //     final responseJson = json.encode({
  //       'data': {
  //         'name': testProductModel.name,
  //         'description': testProductModel.description,
  //         'price': testProductModel.price,
  //         'imageUrl': testProductModel.imageUrl,
  //       },
  //     });
  //     test(
  //       "Should return a prodcutModel when the server returns a 201",
  //       () async {
  //         //arrange
  //         when(mockHttpClient.send(any)).thenAnswer((_) async {
  //           return http.StreamedResponse(
  //               Stream.value(utf8.encode(responseJson)), 201,
  //               headers: {"Content-Type": "application/json"});
  //         });
  //         when(http.MultipartFile.fromPath(
  //           'image',
  //           testProductModel.imageUrl,
  //           contentType: anyNamed('contentType'),
  //         )).thenAnswer((_) async => mockMultipartFile);

  //         //act

  //         final result = await dataSource.addProduct(testProductModel);

  //         //assert
  //         expect(result, equals(testProductModel));
  //       },
  //     );
  //   },
  // );

  group("\n Delte Product \n", () {
    const testId = "1";
    test("should successfully delete a prodcut", () async {
      //arrange
      when(mockHttpClient.delete(
        Uri.parse('$URL/$testId'),
      )).thenAnswer((_) async {
        return http.Response('', 200);
      });
      //act
      final result = await dataSource.deleteProduct(testId);
      //assert

      verify(mockHttpClient.delete(
        Uri.parse('$URL/$testId'),
      ));

      expect(result, equals(unit));
    });

    test("should throw a server exception for other satus codes", () async {
      //arrange
      when(mockHttpClient.delete(
        Uri.parse('$URL/$testId'),
      )).thenAnswer((_) async {
        return http.Response('', 404);
      });
      //act
      final call = dataSource.deleteProduct;
      //assert

      expect(() => call(testId), throwsA(const TypeMatcher<ServerException>()));
    });

    test("should throw a server exception for other satus codes", () async {
      //arrange
      when(mockHttpClient.delete(
        Uri.parse('$URL/$testId'),
      )).thenThrow(http.ClientException("Failed to delete"));
      //act
      final call = dataSource.deleteProduct;
      //assert

      expect(() => call(testId), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
