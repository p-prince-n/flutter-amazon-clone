import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/Order_details/Screen/order_details_screen.dart';
import 'package:amazon/model/order.dart';
import 'package:flutter/material.dart';

class SeeAllOrder extends StatefulWidget {
  static const String routeName = '/see-all-order';
  final List<Order> orders;
  const SeeAllOrder({super.key, required this.orders});

  @override
  State<SeeAllOrder> createState() => _SeeAllOrderState();
}

class _SeeAllOrderState extends State<SeeAllOrder> {
  @override
  Widget build(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Orders.',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.orders.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  OrderDetailsScreen.routeName,
                  arguments: widget.orders[index]),
              child: Column(
                children:
                    List.generate(widget.orders[index].products.length, (i) {
                  return Row(
                    children: [
                      Image.network(
                        widget.orders[index].products[i].images[0],
                        height: 120,
                        width: 120,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.black12,
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.orders[index].products[0].name,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                  'Quantity : ${widget.orders[index].quantity[i].toString()}'),
                              Text(
                                'Product ID : ${widget.orders[index].products[i].id}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Price : \$${widget.orders[index].products[i].price}',
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
