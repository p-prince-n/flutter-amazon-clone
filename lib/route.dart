import 'package:amazon/common/Widgets/bottom_bar.dart';
import 'package:amazon/features/Address/Screen/address_screen.dart';
import 'package:amazon/features/Admin/Widgets/post_screen.dart';
import 'package:amazon/features/All_Order/screens/see_all_order.dart';
import 'package:amazon/features/Order_details/Screen/order_details_screen.dart';
import 'package:amazon/features/auth/Screens/auth_screens.dart';
import 'package:amazon/features/home/screens/home_screen.dart';
import 'package:amazon/features/home/widgets/catagory_deals.dart';
import 'package:amazon/features/products_details/screens/product_details_screen.dart';
import 'package:amazon/features/search/screens/search_screen.dart';
import 'package:amazon/model/order.dart';
import 'package:amazon/model/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case CatagoryDeals.routeName:
      var catagoryArguments = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CatagoryDeals(
          catagroyName: catagoryArguments,
        ),
      );
    case SearchScreen.routeName:
      var searchData = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchdata: searchData,
        ),
      );
    case ProductDetailsScreen.routeName:
      Product product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(
          product: product,
        ),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case PostScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PostScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddressScreen.routeName:
      var amountData = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: amountData,
        ),
      );

    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailsScreen(
          order: order,
        ),
      );
    case SeeAllOrder.routeName:
      var orders = routeSettings.arguments as List<Order>;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SeeAllOrder(
          orders: orders,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Page Not Found'),
          ),
        ),
      );
  }
}
