import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_6/components/large_button.dart';

import 'components/static_card.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  RangeValues _priceRange = const RangeValues(10.0, 80.0);
  TextEditingController catagoryController = TextEditingController();
  TextEditingController filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(20, 5, 5, 0),
          color: const Color(0xFF3F51F3),
          iconSize: 25,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            debugPrint("Go back to the prevois page");
          },
        ),
        title: const Center(
          child: Text(
            "Search Product",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0XFF3E3E3E),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 300,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0XFFD9D9D9),
                    ),
                    child: Stack(
                      children: [
                        TextField(
                          // expands: true,
                          maxLines: null,
                          controller: filterController,
                          decoration: const InputDecoration(
                            hintText: "Leather",
                            hintStyle: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 20,
                            ),
                            fillColor: Color(0xFFFFFFFF),
                            filled: true,
                            border: InputBorder.none,
                            // contentPadding:
                            //     EdgeInsets.symmetric(vertical: 100, horizontal: 60),
                          ),
                        ),
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          top: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF3F51F3),
                                  size: 30,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: const Color(0XFF3F51F3),
                    ),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        debugPrint("filter button clicke");
                      },
                      icon: const Icon(Icons.filter_list_outlined),
                    ),
                  )
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // color: const Color(0xFFFFFFFF),
        // shadowColor: Color.fromARGB(0, 96, 96, 121),
        height: 270,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Catagory",
              style: TextStyle(
                  color: Color(0xFF3E3E3E),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFFD9D9D9)),
              child: TextField(
                // expands: true,
                maxLines: 1,
                controller: catagoryController,
                decoration: InputDecoration(
                  fillColor: const Color(0xFFFFFFFF),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFD9D9D9),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // contentPadding:
                  //     EdgeInsets.symmetric(vertical: 100, horizontal: 60),
                ),
              ),
            ),
            const Text(
              "price",
              style: TextStyle(
                  color: Color(0xFF3E3E3E),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            SizedBox(
              // margin: Ed,
              height: 40,
              width: double.infinity,
              child: RangeSlider(
                values: _priceRange,
                min: 0.0,
                max: 100.0,
                divisions: null,
                activeColor: const Color(0xFF3F51F3),
                inactiveColor: const Color(0xFFD9D9D9),
                labels: RangeLabels(
                  _priceRange.start.toString(),
                  _priceRange.end.toString(),
                ),
                onChanged: (RangeValues value) {
                  setState(() {
                    _priceRange = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            LargeButton(
              const Color(0xFF3F51F3),
              "APPLY",
            )
          ],
        ),
      ),
    );
  }
}
