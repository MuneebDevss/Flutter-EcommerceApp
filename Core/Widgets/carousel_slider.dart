import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../Features/Navigation/Controllers/home_page_controller.dart';



class CarouselSliders extends StatelessWidget {
  const CarouselSliders({super.key, required this.items});
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: items,
        options: CarouselOptions(
          onPageChanged: (index,_)
          {
            HomePageController.page.value=index;
          },
          initialPage: 0,
          enableInfiniteScroll: true,
          viewportFraction: 1,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.decelerate,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,

        )
    );
  }
}
