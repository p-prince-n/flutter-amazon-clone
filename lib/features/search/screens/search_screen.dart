import 'package:amazon/common/Widgets/loader.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/home/widgets/address_bar.dart';
import 'package:amazon/features/products_details/screens/product_details_screen.dart';
import 'package:amazon/features/search/Widgets/search_product.dart';
import 'package:amazon/features/search/services/search_services.dart';
import 'package:amazon/model/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'search-screen';
  final String searchdata;
  const SearchScreen({super.key, required this.searchdata});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices _searchServices = SearchServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchAllDataFromQuery();
  }

  void fetchAllDataFromQuery() async {
    products = await _searchServices.getProductFromSerachQuary(
      context: context,
      searchQuery: widget.searchdata,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          // leading: IconButton(
          //   onPressed: () => Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => HomeScreen(),
          //     ),
          //   ),
          //   icon: Icon(Icons.arrow_back),
          // ),
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
      body: products != null
          ? products!.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text('No Item Found'),
                  ),
                )
              : Column(
                  children: [
                    AddressBar(),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductDetailsScreen.routeName,
                                arguments: products![index],
                              );
                            },
                            child: SearchProduct(product: products![index]),
                          );
                        },
                      ),
                    ),
                  ],
                )
          : Loader(),
    );
  }
}
