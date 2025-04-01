import 'package:amazon/Providers/user_provider.dart';
import 'package:amazon/common/Widgets/custom_button.dart';
import 'package:amazon/common/Widgets/stars.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/constants/utils_alert.dart';
import 'package:amazon/features/Address/Screen/address_screen.dart';
import 'package:amazon/features/products_details/services/product_details_services.dart';
import 'package:amazon/features/search/screens/search_screen.dart';
import 'package:amazon/model/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = 'products-details';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices _productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;
  void addToCart(BuildContext context) {
    _productDetailsServices.addTocart(
        context: context, product: widget.product);
    showSnackBar(context, 'Added To Your cart.');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
      if (totalRating != 0) {
        avgRating = totalRating / widget.product.rating!.length;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            height: 90,
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 45),
                      height: 45,
                      child: Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 1,
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            Navigator.pushNamed(
                              context,
                              SearchScreen.routeName,
                              arguments: value,
                            );
                          },
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(
                              top: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black38,
                              ),
                            ),
                            hintText: 'Search amazon.in',
                            hintStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 42,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Icon(
                      Icons.mic,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  Stars(
                    rating: avgRating,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Text(
                widget.product.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider(
                items: widget.product.images.map((image) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      image,
                      fit: BoxFit.fitHeight,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(height: 300, viewportFraction: 1),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price : ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: '\$${widget.product.price.toString()}',
                      style: TextStyle(
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10).copyWith(
                top: 8,
                bottom: 15,
              ),
              child: Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: CustomButton(
                text: 'Buy Now',
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AddressScreen.routeName,
                    arguments: widget.product.price.toString(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ).copyWith(bottom: 10),
              child: CustomButton(
                color: Color.fromRGBO(254, 216, 19, 1),
                text: 'Add To Cart',
                onTap: () => addToCart(context),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ).copyWith(
                top: 10,
                bottom: 5,
              ),
              alignment: AlignmentDirectional.center,
              child: Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4).copyWith(
                bottom: 10,
              ),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                _productDetailsServices.rateProduct(
                  context: context,
                  product: widget.product,
                  rate: rating,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
