import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';

Widget buildErrorWidget(
  BuildContext context,
  error,
) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Failed to load product.$error'),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          context.read<ProductBloc>().add(const LoadAllProductsEvent());
        },
        child: const Text('Go back to home'),
      ),
    ],
  ));
}
