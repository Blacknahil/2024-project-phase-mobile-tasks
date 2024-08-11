import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_6/components/small_button.dart';

import 'components/size_scrollable.dart';
import 'models/product.dart';
import 'models/products.dart';

class DetailsPage extends StatefulWidget {
  final Product product;

  const DetailsPage({super.key, required this.product});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final eApp = eCommerce();
  var updated = false;
  void _refresh() {
    setState(() {});
  }

  void updateButtonClicked() {
    Navigator.pushNamed(context, '/form', arguments: widget.product)
        .then((result) {
      if (result == true) {
        updated = true;
        _refresh();
      }
    });
  }

  void deleteProduct() {
    eApp.deleteProduct(widget.product.getId ?? 0);

    debugPrint("product being delted ${eApp.products.length}");
    Navigator.pop(context, true);
  }

  final List<int> shoeSizes = [38, 39, 40, 41, 42, 43, 44, 45];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset('images/shoe.png', fit: BoxFit.fitWidth),
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
                    },
                    icon: IconButton(
                      onPressed: () {
                        Navigator.pop(context, updated);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      color: const Color(0xFF3F51F3),
                    ),
                  ),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.getCatagory ?? "",
                        style: const TextStyle(
                          color: Color(0XFFAAAAAA),
                          fontSize: 16.0,
                        ),
                      ),
                      const Row(
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
                        widget.product.getName ?? "",
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF3E3E3E),
                        ),
                      ),
                      Text(
                        "\$ ${widget.product.getPrice}",
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
                        widget.product.getDescription ?? "",
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
                        onPressedFunction: deleteProduct,
                      ),
                      SmallButton(
                        const Color(0xFF3F51F3),
                        "Update",
                        onPressedFunction: updateButtonClicked,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
