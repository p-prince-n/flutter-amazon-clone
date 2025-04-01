import 'package:amazon/common/Widgets/loader.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/Admin/Services/admin_services.dart';
import 'package:amazon/features/Admin/Widgets/post_screen.dart';
import 'package:amazon/features/account/Widgets/single_product.dart';
import 'package:amazon/features/products_details/screens/product_details_screen.dart';
import 'package:amazon/model/product.dart';
import 'package:flutter/material.dart';

class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({super.key});

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {
  List<Product>? products;
  final _adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void fetchAllProducts() async {
    products = await _adminServices.fetchAllProducts(context);
    // print(products?.isNotEmpty);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    _adminServices.deleteProduct(
      context: context,
      product: product,
      onSucces: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (products == null) {
      return const Loader();
    } else if (products!.isEmpty) {
      return Scaffold(
        body: Center(
          child: const Text('There is No Product'),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add a Product',
          shape: CircleBorder(),
          onPressed: () {
            Navigator.pushNamed(context, PostScreen.routeName);
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: GlobalVariables.appBarGradient,
            ),
            child: Icon(
              Icons.add,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    } else {
      return Scaffold(
        body: GridView.builder(
            padding: EdgeInsets.only(top: 12),
            itemCount: products!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final productData = products![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                      arguments: products![index]);
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
                      child: SingleProduct(
                        image: productData.images[0],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () => deleteProduct(productData, index),
                            icon: Icon(
                              Icons.delete_outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add a Product',
          shape: CircleBorder(),
          onPressed: () {
            Navigator.pushNamed(context, PostScreen.routeName);
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: GlobalVariables.appBarGradient,
            ),
            child: Icon(
              Icons.add,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
  }
}
