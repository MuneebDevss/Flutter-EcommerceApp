
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Core/DeviceUtils/device_utils.dart';
import '../../Core/HelpingFunctions/helper_functions.dart';
import '../../Core/constants/sizes.dart';
import '../OnBoardingScreen/Controller/onboarding_controller.dart';

Positioned smoothPageIndicator(BuildContext context) {
  final bool isDark= HelpingFunctions.isDarkMode(context);
  final controller=OnBoardingController.instance;
  return Positioned(
    left: Sizes.defaultSpace,
    bottom: TDeviceUtils.getNavigationHeight(context),
    child: SmoothPageIndicator(
        count:  3,  // PageController
        controller: controller.pageController,
        effect:   ExpandingDotsEffect(
            activeDotColor: isDark?Colors.white:Colors.black,
            dotHeight:6
        ),  // your preferred effect
        onDotClicked: controller.dotNavigation,

    ) ,);
}