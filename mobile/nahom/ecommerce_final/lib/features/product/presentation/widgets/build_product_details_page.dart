import 'package:ecommerce_task_9/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../components/size_scrollable.dart';
import '../components/small_button.dart';

final List<int> shoeSizes = [38, 39, 40, 41, 42, 43, 44, 45];

Widget buildProductDetailsPage(BuildContext context, ProductEntity product) {
  void deleteProduct(String id) {
    context.read<ProductBloc>().add(DeleteProductEvent(id: id));
  }

  void updateButtonClicked(String id) {
    Navigator.pushNamed(
      context,
      '/updateForm',
    ).then((result) {
      if (result == true) {
        context.read<ProductBloc>().add(GetSpecificProductEvent(id: id));
      }
    });
  }

  return SingleChildScrollView(
    child: Column(
      children: [
        Stack(children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(product.imageUrl, fit: BoxFit.fitWidth),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              foregroundDecoration: const BoxDecoration(
                  // color: const Color(0xFFFFFFFF),
                  // borderRadius: BorderRadius.circular(30.0),
                  ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(30.0),
                // border: BoxBorder
              ),
              child: IconButton(
                padding: const EdgeInsets.all(10.0),
                onPressed: () {
                  Navigator.pop(context);
                  context.read<ProductBloc>().add(const LoadAllProductsEvent());
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: const Color(0xFF3F51F3),
              ),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Men's Shoe",
                    style: TextStyle(
                      color: Color(0XFFAAAAAA),
                      fontSize: 16.0,
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
                          fontSize: 16.0,
                          color: Color(0XFFAAAAAA),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF3E3E3E),
                    ),
                  ),
                  Text(
                    "\$ ${product.price}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF3E3E3E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text("Size: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              const SizedBox(),
              SizeScrollable(shoeSizes),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    product.description,
                    style: const TextStyle(
                      color: Color(0XFF666666),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallButton(
                    const Color(0xFFFF1313),
                    "Delete",
                    onPressedFunction: () => deleteProduct(product.id),
                  ),
                  SmallButton(
                    const Color(0xFF3F51F3),
                    "Update",
                    onPressedFunction: () => updateButtonClicked(product.id),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
      ],
    ),
  );
}
