import 'package:ecommerce_app/Core/HelpingFunctions/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_palette.dart';
import '../constants/sizes.dart';
//ignore: must_be_immutable
class MyRectangularImage extends StatelessWidget {
  MyRectangularImage({
    super.key, this.circularRadius, this.width, required this.image, this.height, this.isColored=true, this.light, this.isSelected
  });
  final double? circularRadius, width,height;
  final String image;
  bool isColored;
  final bool? isSelected;
  final Color? light;
  bool isDark=HelpingFunctions.isDarkMode(Get.context!);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        color: isColored?isDark?TColors.dark:light??TColors.light:Colors.transparent,
        borderRadius: BorderRadius.circular(Sizes.md),
        border: isSelected!=null?Border.all(
          width: 4,
          color: TColors.success,
        ):Border.all(
          width: 0,
          color: Colors.transparent
        )
      ),
        width:width?? Sizes.spaceBtwSections*3.4-5-5,
        height: height,

      child: ClipRRect(
          borderRadius: BorderRadius.circular(circularRadius??Sizes.borderRadiusMd),
          child: Image.network(image,fit: BoxFit.cover,filterQuality: FilterQuality.high,)),
    );
  }
}
