import 'package:amazon/features/All_Order/screens/see_all_order.dart';
import 'package:amazon/features/account/Services/account_services.dart';
import 'package:amazon/features/account/Widgets/account_button.dart';
import 'package:amazon/features/auth/Screens/auth_screens.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:amazon/model/order.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AuthService _authService = AuthService();
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
        ? SizedBox()
        : Column(
            children: [
              Row(
                children: [
                  AccountButton(
                    text: 'Your Orders',
                    onTap: () => Navigator.of(context).pushNamed(
                      SeeAllOrder.routeName,
                      arguments: orderList,
                    ),
                  ),
                  AccountButton(
                    text: 'Turn seller',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AccountButton(
                    text: 'Log Out',
                    onTap: () {
                      _authService.signOut(context);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AuthScreen.routeName, (route) => false);
                    },
                  ),
                  AccountButton(
                    text: 'Your Wish List',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          );
  }
}
