import 'dart:convert';

import 'package:amazon/Providers/user_provider.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/constants/utils_alert.dart';
import 'package:amazon/model/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeService {
  Future<List<Product>> getAllCatagoryData({
    required BuildContext context,
    required String catagory,
  }) async {
    List<Product> products = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/products?category=$catagory'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.token,
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            products.add(
              Product.fromJson(
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }

  Future<Product> getDealOfDay({
    required BuildContext context,
  }) async {
    Product product = Product(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: '',
        price: 0);
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/deal-of-days'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    print(product);
    return product;
  }
}
