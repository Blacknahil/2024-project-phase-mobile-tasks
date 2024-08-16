import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String name;
  final String description;
  final String id;
  final String imageUrl;
  final int price;

  const ProductEntity({
    required this.name,
    this.id = '',
    required this.description,
    required this.price,
    this.imageUrl = '',
  });

  @override
  List<Object?> get props => [
        name,
        id,
        description,
        price,
        imageUrl,
      ];
}
