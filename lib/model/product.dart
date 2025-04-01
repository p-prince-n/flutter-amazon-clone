import 'dart:convert';

import 'package:amazon/model/rating.dart';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final String? userId;
  final List<Rating>? rating;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.userId,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'userId': userId,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      rating: map['rating'] != null
          ? List<Rating>.from(
              map['rating']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }
  String toJson() => json.encode(toMap());
  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  // Product copyWith({
  //    String name;
  //  String description;
  //  double quantity;
  //  List<String> images;
  //  String category;
  //  double price;
  //  String? id;
  //  String? userId;
  // }) {
  //   return User(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //     email: email ?? this.email,
  //     password: password ?? this.password,
  //     address: address ?? this.address,
  //     token: token ?? this.token,
  //     type: type ?? this.type,
  //   );
  // }
}
