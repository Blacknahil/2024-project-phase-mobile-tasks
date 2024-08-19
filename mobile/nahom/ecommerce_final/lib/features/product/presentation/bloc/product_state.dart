part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitialState extends ProductState {}

class AllProductsLoadingState extends ProductState {}

class SpecificProductLoadingState extends ProductState {}

class LoadedAllProductsState extends ProductState {
  final List<ProductEntity> products;
  const LoadedAllProductsState(this.products);

  @override
  List<Object?> get props => [products];
}

class LoadedSpecificProductState extends ProductState {
  final ProductEntity product;

  const LoadedSpecificProductState(this.product);

  @override
  List<Object?> get props => [product];
}

class ErrorState extends ProductState {
  final String message;
  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class SucessState extends ProductState {
  final String message;
  const SucessState(this.message);

  @override
  List<Object?> get props => [message];
}
