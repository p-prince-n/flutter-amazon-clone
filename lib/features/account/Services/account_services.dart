import 'dart:convert';

import 'package:amazon/Providers/user_provider.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/constants/utils_alert.dart';
import 'package:amazon/model/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AccountServices {
  Future<List<Order>> getMyOrderData({
    required BuildContext context,
  }) async {
    List<Order> orderList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/order/me'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
            print(
              jsonDecode(res.body)[i],
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }
}
