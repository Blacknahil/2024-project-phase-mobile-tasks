import 'package:flutter/material.dart';

import 'details_page.dart';
import 'form_page.dart';
import 'home_page.dart';
import 'models/product.dart';
import 'search_product_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-commerce',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F51F3)),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          // '/form': (context) => const FormProductPage(),
          '/searchProduct': (context) => const SearchProductPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/details') {
            final product = settings.arguments as Product;
            return MaterialPageRoute(builder: (context) {
              return DetailsPage(
                product: product,
              );
            });
          }
          if (settings.name == '/form') {
            final product = settings.arguments as Product?;
            return MaterialPageRoute(builder: (context) {
              return FormProductPage(
                product: product,
              );
            });
          }
          return null;
        });
  }
}
