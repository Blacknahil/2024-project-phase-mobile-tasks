import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:task_6/models/products.dart';

import 'components/static_card.dart';
import 'models/product.dart';

final product1 = Product(
    id: 1,
    catagory: "Men’s shoe by nahom",
    name: "Derby Leather Shoes Nahom",
    price: 222,
    description:
        "A derby leather shoe is a classic and versatile footwear option characterized by its open "
        "lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). "
        "This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes."
        "Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable"
        "for both formal and casual occasions. With their timeless style and "
        "comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.");

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _refresh() {
    setState(() {});
  }

  void _addNewProduct() {
    Navigator.pushNamed(context, '/form').then((result) {
      if (result == true) {
        _refresh();
      }
    });
  }

  final eApp = eCommerce();
  late int i;
  @override
  void initState() {
    super.initState();
    for (i = 0; i < 3; i++) {
      eApp.addProduct(
        name: product1.getName,
        catagory: product1.getCatagory,
        price: product1.getPrice,
        description: product1.getDescription,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("${eApp.products.length}");

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
      body: SingleChildScrollView(
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
                        Navigator.pushNamed(context, '/searchProduct');
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Color(0XFFD9D9D9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              itemCount: eApp.products.length,
              itemBuilder: (BuildContext context, index) {
                return StaticCard(
                  product: eApp.products[index],
                  onProductChanged: _refresh,
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint("go to the specific page of item");
          },
          backgroundColor: const Color(0XFF3F51F3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: Color(0XFFFFFFFF),
            ),
            onPressed: () {
              _addNewProduct();
              debugPrint("Go to the the page to add a new product");
            },
          )),
    );
  }
}
