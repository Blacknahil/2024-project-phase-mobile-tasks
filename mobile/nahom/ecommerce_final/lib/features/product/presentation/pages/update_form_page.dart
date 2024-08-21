import 'dart:io';

import 'package:ecommerce_task_9/core/util/input_converter.dart';
import 'package:ecommerce_task_9/features/product/domain/entities/product.dart';
import 'package:ecommerce_task_9/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../components/large_button.dart';

class UpdateProductPage extends StatelessWidget {
  const UpdateProductPage({super.key});

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
              Navigator.pop(context, true);
              debugPrint("Go back to the prevouis page");
            },
          ),
          title: const Text(
            "Update Product",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: Color(0XFF3E3E3E),
            ),
          ),
        ),
        body: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 218, 121, 121)),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is SucessState) {
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 218, 121, 121)),
                ),
                duration: const Duration(seconds: 2),
              );

              Navigator.pop(context);
            }
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is SpecificProductLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadedSpecificProductState) {
                final ProductEntity product = state.product;
                return BuildUpdateForm(product: product);
              }
              return TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Center(
                    child: Text("Go back home"),
                  ));
            },
          ),
        ));
  }
}

class BuildUpdateForm extends StatelessWidget {
  final ProductEntity product;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController priceController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late ValueNotifier<String?> _imageUrlNotifier = ValueNotifier<String?>(null);

  BuildUpdateForm({super.key, required this.product})
      : nameController = TextEditingController(text: product.name),
        priceController = TextEditingController(text: product.price.toString()),
        descriptionController =
            TextEditingController(text: product.description),
        imageUrlController = TextEditingController(text: product.imageUrl),
        _imageUrlNotifier = ValueNotifier<String?>(product.imageUrl);

  Future<void> _pickAndSaveImage() async {
    print("trying to pick an image");

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = pickedFile.name;
        final localImage = File('${directory.path}/$fileName');
        await File(pickedFile.path).copy(localImage.path);
        debugPrint('Picked image path: ${localImage.path}');

        // Update the ValueNotifier with the new image URL
        _imageUrlNotifier.value = localImage.path;
        imageUrlController.text = localImage.path;
        debugPrint('Notifier updated: ${_imageUrlNotifier.value}');
      }
    } catch (e) {}
  }

  void _submitForm(
      BuildContext context, ValueNotifier<String?> imageUrlNotfier) async {
    if (_formKey.currentState!.validate() && _imageUrlNotifier.value != null) {
      final newProduct = ProductEntity(
        name: nameController.text,
        description: descriptionController.text,
        price: int.tryParse(priceController.text) ?? 0,
        imageUrl: imageUrlController.text,
        id: product.id,
      );
      context.read<ProductBloc>().add(AddProductEvent(product: newProduct));
      debugPrint("add the product it is valid");
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Fill all required informations",
            style: TextStyle(
              color: Color.fromARGB(255, 218, 121, 121),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    await _pickAndSaveImage();
                  },
                  child: ValueListenableBuilder<String?>(
                    valueListenable: _imageUrlNotifier,
                    builder: (context, imageUrl, _) {
                      return Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(20.0),
                          image: imageUrl != null
                              ? DecorationImage(
                                  image: imageUrl.startsWith("http")
                                      ? NetworkImage(imageUrl)
                                      : FileImage(File(imageUrl))
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: imageUrl == null
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    size: 50,
                                    color: Colors.grey.shade700,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Upload Image',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ))
                            : null,
                      );
                    },
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
                  child: TextFormField(
                    // expands: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter name of the product";
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
                  "price",
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
                            return "Enter a price";
                          } else if (int.tryParse(value) == null) {
                            return "Enter a valid integer";
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
                  child: TextFormField(
                    // expands: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter descripption of the product";
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
                LargeButton(
                  const Color(0xFF3F51F3),
                  "UPDATE",
                  onPressedFunction: () => _submitForm(
                    context,
                    _imageUrlNotifier,
                  ),
                ),
                const SizedBox(height: 20),
                LargeButton(
                  const Color(0xFFFF1313),
                  "DELETE",
                  onPressedFunction: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // return ValueListenableBuilder<String?>
    // (valueListenable: _imageUrlNotifier, builder: builder)
    return Container(
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
    );
  }
}




// 1..for a named parameter navigation i define on the home page how can i define the route ?