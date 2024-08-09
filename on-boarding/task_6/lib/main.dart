import 'package:flutter/material.dart';

import 'add_product_page.dart';
import 'details_page.dart';
import 'home_page.dart';
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
      title: "E-commerce",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F51F3)),
      ),
      home: SearchProductPage(),
    );
  }
}
