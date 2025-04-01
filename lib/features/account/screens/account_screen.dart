import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/account/Widgets/below_app_bar.dart';
import 'package:amazon/features/account/Widgets/orders.dart';
import 'package:amazon/features/account/Widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/images/amazon_in.png',
                      height: 45,
                      width: 120,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 15,
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                          ),
                        ),
                        Icon(
                          Icons.search,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          BelowAppBar(),
          SizedBox(
            height: 10,
          ),
          TopButtons(),
          SizedBox(
            height: 10,
          ),
          Orders(),
        ],
      ),
    );
  }
}
