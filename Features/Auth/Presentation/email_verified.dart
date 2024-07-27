import 'package:ecommerce_app/Core/constants/imageString.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/constants/sizes.dart';

class EmailVerified extends StatelessWidget {
  const EmailVerified({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ConstantImage.emailVerifies,width: 200,height: 200,),
            const SizedBox(height: Sizes.spaceBtwItems,),
            Text('Your account Successfully Created!',style: Theme.of(context).textTheme.headlineSmall,textAlign: TextAlign.center,),
            const SizedBox(height: Sizes.spaceBtwItems,),
            Text('Welcome to Your Ultimate Shopping Destination: Your account is created . Unleash the Joy of Ultimate Seamless online Shopping!',style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,),
            const SizedBox(height: Sizes.spaceBtwSections,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()=>Get.offAll(()=>const LoginPage()),child:
              Text('Continue',style: Theme.of(context).textTheme.bodyLarge!.apply(
                  color: Colors.white
              ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
