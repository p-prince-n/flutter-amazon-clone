import 'package:amazon/common/Widgets/loader.dart';
import 'package:amazon/features/home/services/home_service.dart';
import 'package:amazon/features/products_details/screens/product_details_screen.dart';
import 'package:amazon/model/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeService _homeService = HomeService();
  Product? product;
  @override
  void initState() {
    super.initState();
    getDealOfDaydata();
  }

  void getDealOfDaydata() async {
    product = await _homeService.getDealOfDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Loader(),
          )
        : product!.name.isEmpty
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      ProductDetailsScreen.routeName,
                      arguments: product);
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 10, top: 15),
                      child: Text(
                        'Deat of the Day',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '\$${product!.price}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   padding: EdgeInsets.only(
                    //     left: 15,
                    //     top: 5,
                    //     right: 40,
                    //   ),
                    //   child: Text(
                    //     'Prince',
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Image.network(
                                  e,
                                  fit: BoxFit.fill,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15).copyWith(
                        left: 15,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all Deals',
                        style: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
