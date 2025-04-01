import 'package:amazon/Providers/user_provider.dart';
import 'package:amazon/common/Widgets/bottom_bar.dart';
import 'package:amazon/common/Widgets/custom_button.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/Address/Screen/address_screen.dart';
import 'package:amazon/features/Cart/Widgets/cart_product.dart';
import 'package:amazon/features/Cart/Widgets/cart_sub_total.dart';
import 'package:amazon/features/home/widgets/address_bar.dart';
import 'package:amazon/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 25),
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
          children: [
            AddressBar(),
            if (context.watch<UserProvider>().user.cart.isNotEmpty)
              CartSubTotal(),
            if (context.watch<UserProvider>().user.cart.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 5),
                child: CustomButton(
                    color: Colors.yellow[600],
                    text: 'Proceed to Buy (${user.cart.length}) Items',
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AddressScreen.routeName,
                        arguments: sum.toString(),
                      );
                    }),
              ),
            const SizedBox(
              height: 15,
            ),
            if (context.watch<UserProvider>().user.cart.isNotEmpty)
              Container(
                color: Colors.black12.withValues(alpha: 0.1),
                height: 1,
              ),
            if (context.watch<UserProvider>().user.cart.isNotEmpty)
              const SizedBox(
                height: 5,
              ),
            if (context.watch<UserProvider>().user.cart.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: user.cart.length,
                itemBuilder: (context, index) {
                  return CartProduct(index: index);
                },
              ),
            if (context.watch<UserProvider>().user.cart.isEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 5),
                child: CustomButton(
                    color: Color.fromARGB(255, 29, 201, 192),
                    text: 'Start Shopping Now',
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => BottomBar(),
                          ),
                          (route) => false);
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
