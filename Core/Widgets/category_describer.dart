import 'package:flutter/material.dart';
import '../constants/color_palette.dart';
import '../constants/sizes.dart';

class CategoryDescriber extends StatelessWidget {
  const CategoryDescriber({
    super.key, required this.icon, required this.descriptionText,  this.color=TColors.white,  this.applyRadius=true, this.onTap,
  });
  final Widget icon;
  final String descriptionText;
  final Color color;
  final bool applyRadius;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Sizes.iconXlg,
            height: Sizes.iconXlg,
            decoration:  BoxDecoration(
              color: TColors.white,
              borderRadius:applyRadius? BorderRadius.circular(Sizes.defaultSpace*3):BorderRadius.zero,

            ),
            child: Center(child: icon),
          ),
          const SizedBox(height: Sizes.spaceBtwItems/2,),
          Text(descriptionText,style: Theme.of(context).textTheme.labelLarge!.apply(color: color),),
        ],
      ),
    );
  }
}
