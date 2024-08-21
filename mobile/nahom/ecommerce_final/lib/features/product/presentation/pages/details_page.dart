import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';

import '../widgets/build_error_widgets.dart';
import '../widgets/build_product_details_page.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is SucessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 2),
            ));
            Future.delayed(
              const Duration(seconds: 2),
              () {
                Navigator.pop(context);
              },
            );
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 218, 121, 121)),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is LoadedSpecificProductState) {
              return buildProductDetailsPage(context, state.product);
            } else if (state is ErrorState) {
              return buildErrorWidget(context, state.message);
            } else if (state is SpecificProductLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return TextButton(
                onPressed: () async {
                  context.read<ProductBloc>().add(const LoadAllProductsEvent());
                  Navigator.pop(context, true);
                },
                child: const Center(
                  child: Text("Go back home"),
                ));
          },
        ),
      ),
    );
  }
}
