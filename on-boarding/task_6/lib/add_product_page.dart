import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_6/components/large_button.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController catagoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
        title: const Text(
          "Add Product",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: Color(0XFF3E3E3E),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 190,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0XFFF3F3F3),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: Color(0xFF3E3E3E),
                          size: 70,
                        ),
                        Text(
                          "upload image",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF3E3E3E),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Text(
                  "name",
                  style: TextStyle(
                      color: Color(0xFF3E3E3E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFF3F3F3)),
                  child: TextField(
                    // expands: true,
                    maxLines: null,
                    controller: nameController,
                    decoration: const InputDecoration(
                      fillColor: Color(0xFFF3F3F3),
                      filled: true,
                      border: InputBorder.none,
                      // contentPadding:
                      //     EdgeInsets.symmetric(vertical: 100, horizontal: 60),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Catagory",
                  style: TextStyle(
                      color: Color(0xFF3E3E3E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFF3F3F3)),
                  child: TextField(
                    // expands: true,
                    maxLines: null,
                    controller: catagoryController,
                    decoration: const InputDecoration(
                      fillColor: Color(0xFFF3F3F3),
                      filled: true,
                      border: InputBorder.none,
                      // contentPadding:
                      //     EdgeInsets.symmetric(vertical: 100, horizontal: 60),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "price",
                  style: TextStyle(
                      color: Color(0xFF3E3E3E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFF3F3F3)),
                  child: Stack(
                    children: [
                      TextField(
                        // expands: true,
                        maxLines: null,
                        controller: priceController,
                        decoration: const InputDecoration(
                          fillColor: Color(0xFFF3F3F3),
                          filled: true,
                          border: InputBorder.none,
                          // contentPadding:
                          //     EdgeInsets.symmetric(vertical: 100, horizontal: 60),
                        ),
                      ),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "\$",
                            style: TextStyle(
                              color: Color(0xFF3E3E3E),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "description",
                  style: TextStyle(
                      color: Color(0xFF3E3E3E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFF3F3F3)),
                  child: TextField(
                    // expands: true,
                    maxLines: null,
                    controller: catagoryController,
                    decoration: const InputDecoration(
                      fillColor: Color(0xFFF3F3F3),
                      filled: true,
                      border: InputBorder.none,
                      // contentPadding:
                      //     EdgeInsets.symmetric(vertical: 100, horizontal: 60),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                LargeButton(const Color(0xFF3F51F3), "ADD"),
                const SizedBox(height: 20),
                LargeButton(const Color(0xFFFF1313), "DELETE")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
