import 'package:amazon/common/Widgets/loader.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/home/services/home_service.dart';
import 'package:amazon/features/products_details/screens/product_details_screen.dart';
import 'package:amazon/model/product.dart';
import 'package:flutter/material.dart';

class CatagoryDeals extends StatefulWidget {
  static const String routeName = '/catagory-deals';
  final String catagroyName;
  const CatagoryDeals({super.key, required this.catagroyName});

  @override
  State<CatagoryDeals> createState() => _CatagoryDealsState();
}

class _CatagoryDealsState extends State<CatagoryDeals> {
  final HomeService _homeService = HomeService();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  void fetchCategoryProducts() async {
    products = await _homeService.getAllCatagoryData(
      context: context,
      catagory: widget.catagroyName,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            alignment: Alignment.center,
            height: 90,
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
            child: SafeArea(
              child: Text(
                widget.catagroyName,
                style: TextStyle(
                  // fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: products != null
          ? products!.isEmpty
              ? Center(
                  child: Text(
                    'Currently There is No Item in Stock',
                  ),
                )
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Keep Shopping For ${widget.catagroyName}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 170,
                      child: GridView.builder(
                        itemCount: products!.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.4,
                            mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          final product = products![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ProductDetailsScreen.routeName,
                                  arguments: product);
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Image.network(
                                        product.images[0],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      left: 0, top: 5, right: 15),
                                  child: Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
          : Loader(),
    );
  }
}
