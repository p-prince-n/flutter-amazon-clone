// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon/model/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderAt;
  final int status;
  final double totalAmount;
  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderAt,
    required this.status,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderAt': orderAt,
      'status': status,
      'totalAmount': totalAmount,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
      quantity: List<int>.from(map['products']?.map((x) => x['quantity'])),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderAt: (map['orderAt'] is int)
          ? map['orderAt'] as int
          : int.tryParse(map['orderAt']?.toString() ?? '0') ?? 0,
      status: (map['status'] is int)
          ? map['status'] as int
          : int.tryParse(map['status']?.toString() ?? '0') ?? 0,
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
