import 'package:amazon/constants/global_variable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarousalImage extends StatelessWidget {
  const CarousalImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((image) {
        return Builder(
          builder: (BuildContext context) => Image.network(
            image,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
      options: CarouselOptions(height: 200, viewportFraction: 1),
    );
  }
}
