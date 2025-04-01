import 'dart:io';

import 'package:amazon/common/Widgets/custom_button.dart';
import 'package:amazon/common/Widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/constants/utils_alert.dart';
import 'package:amazon/features/Admin/Services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  static const String routeName = '/post-screen';
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final AdminServices _adminServices = AdminServices();
  String category = 'Mobiles';
  final _addProductFormKey = GlobalKey<FormState>();

  final List<String> productCategories = const [
    'Mobiles',
    'Essentials',
    'Appliences',
    'Books',
    'Fashions',
  ];

  List<File> images = [];
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      _adminServices.sellProduct(
        context: context,
        name: _productNameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        quantity: double.parse(_quantityController.text),
        category: category,
        images: images,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((image) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              image,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                        options:
                            CarouselOptions(height: 200, viewportFraction: 1),
                      )
                    : GestureDetector(
                        onTap: () => selectImages(),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  controller: _productNameController,
                  hintValue: 'Product Name',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _descriptionController,
                  hintValue: 'Description',
                  maxLength: 7,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _priceController,
                  hintValue: 'Price',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _quantityController,
                  hintValue: 'Quantity',
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(
                        () {
                          category = value!;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Sell',
                  onTap: sellProduct,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
