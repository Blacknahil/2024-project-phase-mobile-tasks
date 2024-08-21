import 'package:ecommerce_task_9/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/static_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void _addNewProduct() {
      Navigator.pushNamed(context, '/addForm').then((result) {
        if (result == true) {
          context.read<ProductBloc>().add(LoadAllProductsEvent());
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              margin: const EdgeInsets.fromLTRB(45, 20, 0, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: const Color(0XFFCCCCCC),
              ),
            ),
          ),
          leadingWidth: 120,
          toolbarHeight: 100,
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "July 14,2023",
                    style: TextStyle(
                      color: Color(0XFFAAAAAA),
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hello,",
                    style: TextStyle(
                      color: Color(0XFFAAAAAA),
                      fontSize: 15.0,
                    ),
                  ),
                  Text(
                    " Yohannes",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color(0xFFDDDDDD),
                  )
                  // border: BoxBorder
                  ),
              child: IconButton(
                padding: const EdgeInsets.all(10.0),
                onPressed: () {},
                icon: const Icon(Icons.notifications_active),
              ),
            ),
          ],
        ),
        body: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ErrorState) {
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
          child: Builder(builder: (
            context,
          ) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 30.0, 40.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Available Products",
                          style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Poppins"),
                        ),
                        Container(
                          // margin: const EdgeInsets.only(left: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: const Color(0xFFDDDDDD),
                              )
                              // border: BoxBorder
                              ),
                          child: IconButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: () {
                              context
                                  .read<ProductBloc>()
                                  .add(LoadAllProductsEvent());
                            },
                            icon: const Icon(
                              Icons.restore_outlined,
                              color: Color(0XFFD9D9D9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                    if (state is AllProductsLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LoadedAllProductsState) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: Column(
                            children: state.products
                                .map((product) => StaticCard(product: product))
                                .toList()),
                      );
                    } else {
                      // context.read<ProductBloc>().add(LoadAllProductsEvent());
                      return TextButton(
                          onPressed: () async {
                            context
                                .read<ProductBloc>()
                                .add(const LoadAllProductsEvent());
                          },
                          child: const Center(
                            child: Text("Reload"),
                          ));
                    }
                  })
                ],
              ),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint("go to the specific page of item");
            _addNewProduct();
          },
          backgroundColor: const Color(0XFF3F51F3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.add,
            color: Color(0XFFFFFFFF),
          ),
        ));
  }
}
