import 'package:amazon/common/Widgets/loader.dart';
import 'package:amazon/features/Admin/Services/admin_services.dart';
import 'package:amazon/features/Order_details/Screen/order_details_screen.dart';
import 'package:amazon/features/account/Widgets/single_product.dart';
import 'package:amazon/model/order.dart';
import 'package:flutter/cupertino.dart';

class AdminVeiwOrder extends StatefulWidget {
  const AdminVeiwOrder({super.key});

  @override
  State<AdminVeiwOrder> createState() => _AdminVeiwOrderState();
}

class _AdminVeiwOrderState extends State<AdminVeiwOrder> {
  final AdminServices _adminServices = AdminServices();
  List<Order>? orderList;

  void getOrderData() async {
    orderList = await _adminServices.getAllOrders(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOrderData();
  }

  @override
  Widget build(BuildContext context) {
    return orderList == null
        ? Center(
            child: Loader(),
          )
        : Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 5,
              right: 5,
            ),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: orderList!.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                final orderData = orderList![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        OrderDetailsScreen.routeName,
                        arguments: orderData);
                  },
                  child: SizedBox(
                    height: 140,
                    child: SingleProduct(
                      image: orderData.products[0].images[0],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
