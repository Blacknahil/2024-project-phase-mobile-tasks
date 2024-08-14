import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required String name,
    int id = -1,
    required String description,
    required String catagory,
    String imageUrl = '',
    required int price,
  }) : super(
          name: name,
          id: id,
          description: description,
          catagory: catagory,
          price: price,
          imageUrl: imageUrl,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      description: json['description'],
      catagory: json['catagory'],
      price: json['price'],
      id: json['id'] ?? -1,
      imageUrl: json["imageUrl"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "catagory": catagory,
      "description": description,
      "price": price,
      "imageUrl": imageUrl,
    };
  }

  ProductEntity toEntity() {
    return ProductModel(
      id: id,
      name: name,
      price: price,
      description: description,
      catagory: catagory,
      imageUrl: imageUrl,
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      name: entity.name,
      description: entity.description,
      catagory: entity.catagory,
      price: entity.price,
      id: entity.id,
      imageUrl: entity.imageUrl,
    );
  }
}
