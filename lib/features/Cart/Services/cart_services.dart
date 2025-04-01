import 'dart:convert';

import 'package:amazon/Providers/user_provider.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/constants/utils_alert.dart';
import 'package:amazon/model/product.dart';
import 'package:amazon/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartServices {
  void removeFromcart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              cart: jsonDecode(res.body)['cart'],
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
