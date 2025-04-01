import 'package:amazon/common/Widgets/stars.dart';
import 'package:amazon/model/product.dart';
import 'package:flutter/material.dart';

class SearchProduct extends StatelessWidget {
  final Product product;
  const SearchProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double avgRating = 0;
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;

      if (totalRating != 0) {
        avgRating = totalRating / product.rating!.length;
      }
    }

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Stars(
                      rating: avgRating,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Eligible for free Shipping',
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: product.quantity != 0
                        ? Text(
                            'In Stock',
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                            maxLines: 2,
                          )
                        : Text(
                            'Out of Stock',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                            maxLines: 2,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
