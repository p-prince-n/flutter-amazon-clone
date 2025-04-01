import 'package:amazon/common/Widgets/loader.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/All_Order/screens/see_all_order.dart';
import 'package:amazon/features/account/Services/account_services.dart';
import 'package:amazon/features/account/Widgets/single_product.dart';
import 'package:amazon/model/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final AccountServices _accountServices = AccountServices();
  List<Order>? orderList;

  @override
  void initState() {
    super.initState();
    getOrderData();
  }

  void getOrderData() async {
    orderList = await _accountServices.getMyOrderData(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orderList == null
        ? Loader()
        : orderList!.isEmpty
            ? SizedBox()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: Text(
                          'Your Orders',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          right: 15,
                        ),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              SeeAllOrder.routeName,
                              arguments: orderList),
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: GlobalVariables.selectedNavBarColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 170,
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 20,
                      right: 0,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orderList!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              '/order-details',
                              arguments: orderList![index]),
                          child: SingleProduct(
                            image: orderList![index].products[0].images[0],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
  }
}
