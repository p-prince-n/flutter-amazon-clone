import 'dart:convert';
import 'dart:io';

import 'package:amazon/Providers/user_provider.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/constants/utils_alert.dart';
import 'package:amazon/features/Admin/model/sales.dart';
import 'package:amazon/model/order.dart';
import 'package:amazon/model/product.dart';
// import 'package:amazon/model/user.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final cloudinary = CloudinaryPublic('_cloudName', '_uploadPreset');
      //create your account from cloudinay and add _cloudName and _uploadPreset from cloudinary website after creating your account.
      List<String> imagesURL = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imagesURL.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imagesURL,
        category: category,
        price: price,
      );
      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.token,
          },
          body: product.toJson());

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added successfully.');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    List<Product> products = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/admin/get-products'), headers: <String, String>{
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

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSucces}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.post(
          Uri.parse('$uri/admin/delete-product'),
          body: jsonEncode({'id': product.id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.token,
          });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () => onSucces,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> getAllOrders(BuildContext context) async {
    List<Order> orderList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.get(Uri.parse('$uri/admin/get-all-orders'),
          headers: <String, String>{
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
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void changrOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSucces,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/admin/change-order-status'),
              body: jsonEncode({
                'id': order.id,
                'status': status,
              }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.token,
          });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSucces,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    List<Sales> sales = [];
    int totalEarning = 0;
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/admin/analytics'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarning'];
          sales = [
            Sales('Mobiles', response['mobileEarning']),
            Sales('Essantials', response['essentialsEarning']),
            Sales('Appliances', response['appliancesEarning']),
            Sales('Books', response['booksEarning']),
            Sales('Fashion', response['fashionEarning']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarning': totalEarning,
    };
  }
}
