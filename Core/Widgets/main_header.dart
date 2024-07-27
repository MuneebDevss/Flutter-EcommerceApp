import 'package:flutter/material.dart';

import '../DeviceUtils/device_utils.dart';
import '../constants/color_palette.dart';
import '../constants/sizes.dart';
import 'circular_containers.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    super.key,
    required this.column, this.height,
  });
  final Widget column;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height??TDeviceUtils.getScreenHeight(context) * 0.5,
      decoration: const BoxDecoration(
        color: TColors.success,
      ),
      child: Stack(children: [
        const Positioned(
            right: -Sizes.appBarHeight * 4,
            top: Sizes.appBarHeight * 2.2,
            child: CircularContainer()),
        const Positioned(
          right: -Sizes.appBarHeight * 3.2,
          top: -Sizes.appBarHeight * 2,
          child: CircularContainer(),
        ),
        column,
      ]),
    );
  }
}
