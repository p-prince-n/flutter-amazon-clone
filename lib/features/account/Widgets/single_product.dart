import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final double? width;
  const SingleProduct({super.key, required this.image, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: width ?? 180,
          padding: EdgeInsets.all(10),
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            width: width ?? 180,
          ),
        ),
      ),
    );
  }
}
