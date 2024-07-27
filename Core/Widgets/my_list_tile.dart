//ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../HelpingFunctions/helper_functions.dart';
import '../constants/color_palette.dart';
import '../constants/sizes.dart';
//ignore:must_be_immutable
class MyListTile extends StatelessWidget {
  MyListTile({
    super.key,
    required this.title, required this.subtitle, this.trailing, this.leading, this.dark, this.light, this.onTap, this.onLongPressed, this.useWidth,
  });

  bool isDark = HelpingFunctions.isDarkMode(Get.context!);
  final String title,subtitle;
  final double? useWidth;
  final Widget?trailing;
  final Widget? leading;
  final Color? dark,light;
  final VoidCallback? onLongPressed;final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: isDark
              ? dark??TColors.black
              :light?? TColors.white.withOpacity(0.5),
          borderRadius:
          BorderRadius.circular(Sizes.borderRadiusXlg),
        ),
        width:useWidth?? Sizes.buttonWidth * 2.9,
        child: Center(
          child: ListTile(
            leading: leading,
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              subtitle,
              style: Theme.of(context).textTheme.labelLarge
            ),
            trailing: trailing??trailing,
            onLongPress: onLongPressed,
            onTap: onTap,
          ),
        ));
  }
}