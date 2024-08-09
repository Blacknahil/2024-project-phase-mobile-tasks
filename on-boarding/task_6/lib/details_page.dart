import 'package:flutter/material.dart';
import 'package:task_6/components/small_button.dart';

import 'components/size_scrollable.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key});

  final List<int> shoeSizes = [38, 39, 40, 41, 42, 43, 44, 45];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset('images/shoe.png', fit: BoxFit.fitWidth),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Men's shoe",
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Derby Leather Shoes",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF3E3E3E),
                        ),
                      ),
                      Text(
                        "\$120",
                        style: TextStyle(
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
                  const Column(
                    children: [
                      Text(
                        'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system'
                        'where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual'
                        'look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and '
                        'elegance, making them suitable for both formal and casual occasions.'
                        ' With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
                        style: TextStyle(
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
                      SmallButton(const Color(0xFFFF1313), "Delete"),
                      SmallButton(const Color(0xFF3F51F3), "Update"),
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
