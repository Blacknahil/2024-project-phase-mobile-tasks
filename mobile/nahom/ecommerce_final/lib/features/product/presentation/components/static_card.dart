import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StaticCard extends StatelessWidget {
  final ProductEntity product;
  const StaticCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        onTap: () {
          debugPrint("Go to the details of ${product.id}");
          context
              .read<ProductBloc>()
              .add(GetSpecificProductEvent(id: product.id));
          Navigator.pushNamed(
            context,
            '/details',
          ).then((result) {
            if (result == true) {
              context.read<ProductBloc>().add(LoadAllProductsEvent());
            }
          });
        },
        child: Card(
          color: const Color(0XFFFFFFFF),
          // clipBehavior: Clip.antiAlias,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error)

                    // fit: BoxFit.fitWidth,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${product.name}",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF3E3E3E),
                      ),
                    ),
                    Text(
                      "\$ ${product.price}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF3E3E3E),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Men’s shoe by nahom",
                      style: TextStyle(
                        color: Color(0XFFAAAAAA),
                        fontSize: 12.0,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(0XFFFFD700),
                          size: 25,
                        ),
                        Text(
                          "(4.0)",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0XFFAAAAAA),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
