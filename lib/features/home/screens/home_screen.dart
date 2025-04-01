import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/home/widgets/address_bar.dart';
import 'package:amazon/features/home/widgets/carousal_image.dart';
import 'package:amazon/features/home/widgets/deal_of_day.dart';
import 'package:amazon/features/home/widgets/top_catagories.dart';
import 'package:amazon/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          children: const [
            AddressBar(),
            SizedBox(
              height: 10,
            ),
            TopCatagories(),
            SizedBox(
              height: 10,
            ),
            CarousalImage(),
            DealOfDay(),
          ],
        ),
      ),
    );
  }
}
