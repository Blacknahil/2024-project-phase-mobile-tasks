// ignore: file_names
import 'package:flutter/material.dart';

import 'components/large_button.dart';
import 'models/product.dart';
import 'models/products.dart';

class FormProductPage extends StatefulWidget {
  final Product? product;
  const FormProductPage({super.key, this.product});

  @override
  State<FormProductPage> createState() => _FormProductPageState();
}

class _FormProductPageState extends State<FormProductPage> {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController catagoryController = TextEditingController();
  late TextEditingController priceController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final eApp = ECommerce();

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.product?.getName ?? '');
    catagoryController =
        TextEditingController(text: widget.product?.getCatagory ?? '');
    priceController =
        TextEditingController(text: widget.product?.getPrice.toString() ?? '');

    descriptionController =
        TextEditingController(text: widget.product?.getDescription ?? '');
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (widget.product == null) {
        eApp.addProduct(
          name: nameController.text,
          catagory: catagoryController.text,
          description: descriptionController.text,
          price: int.tryParse(priceController.text),
        );
      } else {
        bool success = eApp.updateProduct(
          id: widget.product!.getId!,
          name: nameController.text,
          catagory: catagoryController.text,
          price: int.tryParse(priceController.text),
          description: descriptionController.text,
        );
      }
      debugPrint('add the product it is valid');

      Navigator.pop(context, true);
    } else {
      debugPrint('invalid Product');
    }
  }

  void _deleteForm() {
    debugPrint('go back and delete the form');
    Navigator.pop(context);
  }

  void check() {
    if (widget.product != null) {
      debugPrint('Product has been recieved');
    } else {
      debugPrint('Produt not recievd');
    }
  }

  @override
  Widget build(BuildContext context) {
    check();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(20, 5, 5, 0),
          color: const Color(0xFF3F51F3),
          iconSize: 25,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
            debugPrint('Go back to the prevouis page');
          },
        ),
        title: Text(
          widget.product == null
              ? 'Add Product'
              : 'Update ${widget.product?.getName}',
          style: const TextStyle(
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
                          'upload image',
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
                  'name',
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
                  child: TextFormField(
                    // expands: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter name of the product';
                      }
                      return null;
                    },
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
                  'Catagory',
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
                  child: TextFormField(
                    // expands: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter the catagory of the product';
                      }
                      return null;
                    },
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
                  'price',
                  style: TextStyle(
                      color: Color(0xFF3E3E3E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFF3F3F3)),
                  child: Stack(
                    children: [
                      TextFormField(
                        // expands: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a price';
                          } else if (int.tryParse(value) == null) {
                            return 'Enter a valid integer';
                          }
                          return null;
                        },
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
                            '\$',
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
                  'description',
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
                  child: TextFormField(
                    // expands: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter descripption of the product';
                      }
                      return null;
                    },
                    maxLines: null,
                    controller: descriptionController,
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
                LargeButton(const Color(0xFF3F51F3),
                    widget.product == null ? 'ADD' : 'UPDATE',
                    onPressedFunction: _submitForm),
                const SizedBox(height: 20),
                if (widget.product == null)
                  LargeButton(
                    const Color(0xFFFF1313),
                    'DELETE',
                    onPressedFunction: _deleteForm,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
