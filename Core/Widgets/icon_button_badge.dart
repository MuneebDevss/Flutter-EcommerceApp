import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../HelpingFunctions/helper_functions.dart';
import '../constants/color_palette.dart';
import '../constants/sizes.dart';

class IconButtonBadge extends StatelessWidget {
   IconButtonBadge(
      {
        super.key, required this.icon,
        this.badgeNumber='0', required this.onPressed
      });
  final Icon icon;
  final VoidCallback onPressed;
  final String badgeNumber;
  bool isDark=HelpingFunctions.isDarkMode(Get.context!);
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        right: 0,
        child: Container(
          width: Sizes.iconMd-5,
          height: Sizes.iconMd-5,
          decoration: BoxDecoration(
              color:isDark? TColors.black:TColors.grey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(Sizes.lg)
          ),
          child: Center(child: Text(badgeNumber,style:Theme.of(context).textTheme.labelLarge),),
        ),
      ),
      IconButton(onPressed: onPressed, icon: icon)
    ]);
  }
}
