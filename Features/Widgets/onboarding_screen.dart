import 'package:ecommerce_app/Core/DeviceUtils/device_utils.dart';
import 'package:flutter/material.dart';

class OnboardingScreens extends StatelessWidget {
  const OnboardingScreens({
    super.key, required this.image, required this.firstText, required this.secondText,
  });
  final String image,firstText,secondText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          width: TDeviceUtils.getScreenWidth(context)*0.6,
          height: TDeviceUtils.getScreenHeight(context)*0.6,
          fit: BoxFit.fitWidth,
        ),
        Text(firstText,style: Theme.of(context).textTheme.headlineMedium),
        Text(secondText,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,),
      ],

    );
  }
}
