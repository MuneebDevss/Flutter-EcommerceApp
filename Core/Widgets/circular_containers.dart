import 'package:flutter/material.dart';

import '../constants/sizes.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key, this.color=Colors.white, this.width=Sizes.appBarHeight * 6, this.height=Sizes.appBarHeight * 6, this.child,
  });
  final Color color;
  final double width,height;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.appBarHeight * 6),
        color: color==Colors.white?color.withOpacity(0.2):color,
      ),
      child: Center(child: child),
    );
  }
}
