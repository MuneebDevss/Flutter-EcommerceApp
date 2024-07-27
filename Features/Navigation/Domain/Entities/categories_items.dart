import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Core/DeviceUtils/device_utils.dart';
import '../../../../Core/constants/imageString.dart';
import '../../../../Core/constants/sizes.dart';

class CategoriesItems
{
  static List<Widget> items = [
    Container(
      decoration: const BoxDecoration(
        border: Border(),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.defaultSpace),
          child: Image.asset(
            ConstantImage.banner1,
            width: TDeviceUtils.getScreenWidth(Get.context!) * 0.9,
            height: TDeviceUtils.getScreenHeight(Get.context!) * 0.2,
            fit: BoxFit.fitWidth,
          )),
    ),
    Container(
      decoration: const BoxDecoration(
        boxShadow: [],
        border: Border(),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.defaultSpace),
          child: Image.asset(
            ConstantImage.banner2,
            width: TDeviceUtils.getScreenWidth(Get.context!) * 0.9,
            height: TDeviceUtils.getScreenHeight(Get.context!) * 0.2,
            fit: BoxFit.cover,
          )),
    ),
    Container(
      decoration: const BoxDecoration(
        boxShadow: [],
        border: Border(),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.defaultSpace),
          child: Image.asset(
            ConstantImage.banner3,
            width: TDeviceUtils.getScreenWidth(Get.context!) * 0.9,
            height: TDeviceUtils.getScreenHeight(Get.context!) * 0.2,
            fit: BoxFit.cover,
          )),
    ),
  ];
}