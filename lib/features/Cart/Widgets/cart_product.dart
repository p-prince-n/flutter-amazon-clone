import 'package:amazon/Providers/user_provider.dart';
import 'package:amazon/features/Cart/Services/cart_services.dart';
import 'package:amazon/features/products_details/services/product_details_services.dart';
import 'package:amazon/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices _productDetailsServices =
      ProductDetailsServices();
  final CartServices _cartServices = CartServices();
  void increaseQunatity(BuildContext context, Product product) {
    _productDetailsServices.addTocart(context: context, product: product);
  }

  void decreaseQunatity(BuildContext context, Product product) {
    _cartServices.removeFromcart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 115,
                width: 115,
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
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreaseQunatity(context, product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),
                        color: Colors.white,
                      ),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(quantity.toString()),
                      ),
                    ),
                    InkWell(
                      onTap: () => increaseQunatity(context, product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
