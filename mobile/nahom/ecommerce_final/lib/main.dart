import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/presentation/bloc/bloc_obeserver.dart';
import 'package:ecommerce_task_9/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_task_9/features/product/presentation/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/product/presentation/pages/details_page.dart';
import 'features/product/presentation/pages/update_form_page.dart';
import 'features/product/presentation/pages/home_page.dart';
import "injection_container.dart" as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final bloc = sl<ProductBloc>();
            bloc.add(
              const LoadAllProductsEvent(),
            );
            return bloc;
          },
          child: Container(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "E-commerce",
          // theme: ThemeData(
          //   colorScheme:
          //       ColorScheme.fromSeed(seedColor: const Color(0xFF3F51F3)),
          // ),

          theme: ThemeData(
            primaryColor: const Color(0xFFFFFFFF), // White color
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFFFFFFF), // AppBar background color
              titleTextStyle: TextStyle(
                color: Color(0xFF000000), // Black color for AppBar title text
              ),
              iconTheme: IconThemeData(
                color: Color(0xFF000000), // Black color for AppBar icons
              ),
            ),
            buttonTheme: const ButtonThemeData(
              buttonColor: Color(0xFF3F51F3), // Button background color
              textTheme: ButtonTextTheme.primary, // Makes the text color white
            ),
            textTheme: const TextTheme(
              labelLarge: TextStyle(
                  color: Color.fromARGB(
                      255, 8, 8, 8)), // White color for button text
              bodyLarge: TextStyle(
                  color: Color.fromARGB(
                      255, 9, 9, 9)), // White color for general text
              bodyMedium: TextStyle(
                  color: Color.fromARGB(
                      255, 15, 15, 15)), // White color for general text
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF3F51F3)),
                foregroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFFFFFFFF)),
              ),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/updateForm': (context) => const UpdateProductPage(),
            '/addForm': (context) => const AddProductPage(),
            // '/searchProduct': (context) => const SearchProductPage(),
            '/details': (context) => const DetailsPage(),
          },
          onGenerateRoute: (settings) {
            return null;
          }),
    );
  }
}
