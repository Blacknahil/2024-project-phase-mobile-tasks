import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'components/static_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // List<GestureDetector> _buildGridCards(BuildContext context) {
  //   return [];
  // }

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
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
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                return const StaticCard();
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
              debugPrint("Go to the the page to add a new product");
            },
          )),
    );
  }
}
