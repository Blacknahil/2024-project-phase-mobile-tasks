import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_task_9/core/error/failure.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce_task_9/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late ProductBloc productBloc;
  late MockAddProduct mockAddProductUseCase;
  late MockUpdateProduct mockUpdateProductUseCase;
  late MockDeleteProduct mockDeleteProductUseCase;
  late MockGetAllProducts mockGetAllProductsUseCase;
  late MockGetSpecificProduct mockGetSpecificProductUseCase;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockAddProductUseCase = MockAddProduct();
    mockUpdateProductUseCase = MockUpdateProduct();
    mockDeleteProductUseCase = MockDeleteProduct();
    mockGetAllProductsUseCase = MockGetAllProducts();
    mockGetSpecificProductUseCase = MockGetSpecificProduct();
    mockInputConverter = MockInputConverter();
    productBloc = ProductBloc(
      addProductUseCase: mockAddProductUseCase,
      getAllProductsUseCase: mockGetAllProductsUseCase,
      getSpecificProductUseCase: mockGetSpecificProductUseCase,
      updateProductUseCase: mockUpdateProductUseCase,
      deleteProductUseCase: mockDeleteProductUseCase,
      inputConverter: mockInputConverter,
    );
  });

  const testProductEntity = ProductEntity(
      name: "test_name",
      description: "test_description",
      price: 10,
      id: "1",
      imageUrl: "url");
  const testId = "1";
  const testProductEntityList = [testProductEntity];
  test(
    "intial State should be intital state",
    () {
      expect(productBloc.state, equals(ProductInitialState()));
    },
  );

  group(
    "AddProductEvent test",
    () {
      blocTest<ProductBloc, ProductState>(
        'emits [SpecificProductLoadingState, ErrorState] when AddProductEvent fails',
        build: () {
          when(mockAddProductUseCase.execute(any)).thenAnswer(
              (_) async => const Left(ServerFailure('Error message')));
          return productBloc;
        },
        act: (bloc) =>
            bloc.add(const AddProductEvent(product: testProductEntity)),
        expect: () => [
          SpecificProductLoadingState(),
          const ErrorState('Error message'),
        ],
      );

      blocTest<ProductBloc, ProductState>(
          "Should emit [SpecificProductLoadingState, SpecificProductLoaded when addproduct Event Occurs",
          build: () {
            when(mockAddProductUseCase.execute(testProductEntity))
                .thenAnswer((_) async {
              return const Right(testProductEntity);
            });
            return productBloc;
          },
          act: (bloc) =>
              bloc.add(const AddProductEvent(product: testProductEntity)),
          expect: () => [
                SpecificProductLoadingState(),
                const LoadedSpecificProductState(testProductEntity)
              ]);
    },
  );

  group("Delete Product Event test", () {
    blocTest<ProductBloc, ProductState>(
        "should emit [SpecificProductLoadingState,SucessState] on successful deleteion",
        build: () {
          when(mockDeleteProductUseCase.execute(testId)).thenAnswer((_) async {
            return const Right(unit);
          });
          return productBloc;
        },
        act: (bloc) => bloc.add(const DeleteProductEvent(id: testId)),
        expect: () => [
              SpecificProductLoadingState(),
              const SucessState("Successfully deleted product.")
            ]);

    blocTest<ProductBloc, ProductState>(
        "should emit [SpecificProductLoadingState,ErrorState] on Failure",
        build: () {
          when(mockDeleteProductUseCase.execute(testId)).thenAnswer((_) async {
            return const Left(ServerFailure(""));
          });
          return productBloc;
        },
        act: (bloc) => bloc.add(const DeleteProductEvent(id: testId)),
        expect: () => [
              SpecificProductLoadingState(),
              const ErrorState(""),
            ]);
  });

  group('GetAllProductsEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [AllProductsLoadingState, LoadedAllProductsState] when GetAllProductsEvent is successful',
      build: () {
        when(mockGetAllProductsUseCase.execute(any))
            .thenAnswer((_) async => const Right(testProductEntityList));
        return productBloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductsEvent()),
      expect: () => [
        AllProductsLoadingState(),
        const LoadedAllProductsState(testProductEntityList),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [AllProductsLoadingState, ErrorState] when GetAllProductsEvent fails',
      build: () {
        when(mockGetAllProductsUseCase.execute(any))
            .thenAnswer((_) async => const Left(ServerFailure('')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductsEvent()),
      expect: () => [
        AllProductsLoadingState(),
        const ErrorState(''),
      ],
    );
  });

  group(
    "Update Product event test",
    () {
      blocTest<ProductBloc, ProductState>(
        'emits [AllProductsLoadingState, ErrorState] when GetAllProductsEvent fails',
        build: () {
          when(mockUpdateProductUseCase.execute(testProductEntity))
              .thenAnswer((_) async => const Right(testProductEntity));
          return productBloc;
        },
        act: (bloc) =>
            bloc.add(const UpdateProductEvent(product: testProductEntity)),
        expect: () => [
          SpecificProductLoadingState(),
          const SucessState("Successfully Updated product."),
          const LoadedSpecificProductState(testProductEntity),
        ],
      );

      blocTest<ProductBloc, ProductState>(
        'emits [AllProductsLoadingState, ErrorState] when GetAllProductsEvent fails',
        build: () {
          when(mockUpdateProductUseCase.execute(testProductEntity))
              .thenAnswer((_) async => const Left(ServerFailure("")));
          return productBloc;
        },
        act: (bloc) =>
            bloc.add(const UpdateProductEvent(product: testProductEntity)),
        expect: () => [
          SpecificProductLoadingState(),
          const ErrorState(""),
        ],
      );
    },
  );

  group(
    "Get Specific Product event test",
    () {
      blocTest<ProductBloc, ProductState>(
        'emits [SpecificLoadingState, LoadedSpecificState] when GetSpecificProduct state is success',
        build: () {
          when(mockGetSpecificProductUseCase.execute(testId))
              .thenAnswer((_) async => const Right(testProductEntity));
          return productBloc;
        },
        act: (bloc) => bloc.add(const GetSpecificProductEvent(id: testId)),
        expect: () => [
          SpecificProductLoadingState(),
          const LoadedSpecificProductState(testProductEntity)
        ],
      );

      blocTest<ProductBloc, ProductState>(
        'emits [SpecificLoadingState, ErrorState] when GetSpecificProduct state is success',
        build: () {
          when(mockGetSpecificProductUseCase.execute(testId))
              .thenAnswer((_) async => const Left(ServerFailure("")));
          return productBloc;
        },
        act: (bloc) => bloc.add(const GetSpecificProductEvent(id: testId)),
        expect: () => [
          SpecificProductLoadingState(),
          const ErrorState(""),
        ],
      );
    },
  );
}
