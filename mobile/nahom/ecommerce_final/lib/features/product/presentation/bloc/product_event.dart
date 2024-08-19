part of 'product_bloc.dart';

@immutable
sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllProductsEvent extends ProductEvent {
  const LoadAllProductsEvent();
}

class GetSpecificProductEvent extends ProductEvent {
  final String id;

  const GetSpecificProductEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity product;

  const UpdateProductEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String id;

  const DeleteProductEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class AddProductEvent extends ProductEvent {
  final ProductEntity product;

  const AddProductEvent({required this.product});
  @override
  List<Object?> get props => [product];
}
