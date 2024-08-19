import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_task_9/core/util/input_converter.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/get_specifc_product.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/update_product.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/get_all_products.dart';

part 'product_event.dart';
part 'product_state.dart';

const String Server_Failure_Message = "Server Failure";
const String Cache_Failure_Message = "Cache Failure";
const String Invalid_Input_Message = "Invalid Input";

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddProduct addProductUseCase;
  final GetAllProducts getAllProductsUseCase;
  final GetSpecificProduct getSpecificProductUseCase;
  final UpdateProduct updateProductUseCase;
  final DeleteProduct deleteProductUseCase;
  final InputConverter inputConverter;
  ProductBloc({
    required this.addProductUseCase,
    required this.getAllProductsUseCase,
    required this.getSpecificProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
    required this.inputConverter,
  }) : super(ProductInitialState()) {
    on<LoadAllProductsEvent>(_getAllProductsRequested);
    on<AddProductEvent>(_addedProduct);
    on<GetSpecificProductEvent>(_getSpecificProductRequested);
    on<DeleteProductEvent>(_productDeleted);
    on<UpdateProductEvent>(_productUpdated);
  }

  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    //ToDo Logic
  }

  ProductState get initialState => ProductInitialState();

  Future<void> _addedProduct(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(SpecificProductLoadingState());
    final result = await addProductUseCase.execute(event.product);

    result.fold(
      (left) {
        emit(ErrorState(left.message));
      },
      (right) {
        emit(LoadedSpecificProductState(right));
      },
    );
  }

  Future<void> _getAllProductsRequested(
    LoadAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(AllProductsLoadingState());

    final result = await getAllProductsUseCase.execute(NoParams());

    result.fold(
      (left) {
        emit(ErrorState(left.message));
      },
      (right) {
        emit(LoadedAllProductsState(right));
      },
    );
  }

  Future<void> _getSpecificProductRequested(
    GetSpecificProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(SpecificProductLoadingState());

    final result = await getSpecificProductUseCase.execute(event.id);

    result.fold(
      (left) {
        emit(ErrorState(left.message));
      },
      (right) {
        emit(LoadedSpecificProductState(right));
      },
    );
  }

  Future<void> _productUpdated(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(SpecificProductLoadingState());

    final result = await updateProductUseCase.execute(event.product);

    result.fold(
      (left) {
        emit(ErrorState(left.message));
      },
      (right) {
        emit(const SucessState("Successfully Updated product."));
        emit(LoadedSpecificProductState(right));
      },
    );
  }

  Future<void> _productDeleted(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(SpecificProductLoadingState());

    final result = await deleteProductUseCase.execute(event.id);

    result.fold(
      (left) {
        emit(ErrorState(left.message));
      },
      (right) {
        emit(SpecificProductLoadingState());
        emit(const SucessState("Successfully deleted product."));
      },
    );
  }
}
