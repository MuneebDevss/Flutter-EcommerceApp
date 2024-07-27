import 'package:ecommerce_app/Core/DeviceUtils/device_utils.dart';
import 'package:ecommerce_app/Core/HelpingFunctions/helper_functions.dart';
import 'package:ecommerce_app/Core/constants/imageString.dart';
import 'package:ecommerce_app/Features/OnBoardingScreen/Controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/constants/sizes.dart';
import '../../../Core/constants/text_constants.dart';

import '../../Widgets/onboarding_screen.dart';
import '../../Widgets/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  @override
  Widget build(BuildContext context) {
     OnBoardingController controller=Get.put(OnBoardingController());
    return  Scaffold(
      body: Stack(
        children: [

          PageView(
            controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: const [
                OnboardingScreens(image: ConstantImage.page1, firstText: ConstantTexts.onBoardingTitle1, secondText: ConstantTexts.onBoardingSubTitle1,),
                OnboardingScreens(image: ConstantImage.page2, firstText: ConstantTexts.onBoardingTitle2, secondText: ConstantTexts.onBoardingSubTitle2,),
                OnboardingScreens(image: ConstantImage.page3, firstText: ConstantTexts.onBoardingTitle3, secondText: ConstantTexts.onBoardingSubTitle3,),
          ]
          ),
          Positioned(
            right: Sizes.defaultSpace,
              top: TDeviceUtils.getStatusBarHeight(context),
              child: TextButton(onPressed: ()=>controller.skip(), child: const Text('Skip'))),
          smoothPageIndicator(context),
          //button
          const Forward(),
        ],
      ),
    );
  }
}

class Forward extends StatelessWidget {
  const Forward({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark=HelpingFunctions.isDarkMode(context);
    return Positioned(
      right: Sizes.defaultSpace,
        bottom: TDeviceUtils.getNavigationHeight(context),
        child: ElevatedButton(onPressed: ()=>OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          backgroundColor:isDark? Colors.blue:Colors.black,
          shape: const CircleBorder()
        ),
    child: const Icon(Icons.arrow_forward_ios),)
    
    
    );
  }
}

