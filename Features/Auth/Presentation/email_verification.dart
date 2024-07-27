import 'package:ecommerce_app/Core/constants/imageString.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/AuthBloc/auth_bloc.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/Controllers/email_verification_controller.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/email_verified.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../Core/constants/color_palette.dart';
import '../../../Core/constants/sizes.dart';

class EmailVerifcation extends StatelessWidget {
   EmailVerifcation({super.key, required this.email});
  final String email;
  final controller=Get.put(EmailVerificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: BlocListener<AuthBloc,AuthState>(
          listener: (BuildContext context, state) {
            if(state is Failure){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
            if(state is EmailSent)
            {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check your email and verify'),backgroundColor: TColors.success,));
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ConstantImage.emailVerification,width: 200,height: 200,),
              const SizedBox(height: Sizes.spaceBtwItems,),
              Text('Verify Your Email address!',style: Theme.of(context).textTheme.headlineSmall,textAlign: TextAlign.center,),
              const SizedBox(height: Sizes.spaceBtwItems,),
              Text(email,style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),
              const SizedBox(height: Sizes.spaceBtwItems,),
              Text('Congratulations! Your Account Awaits, Verify Your Email to Start Shopping and Experience a real World of Unrivaled Deals and Personalised Offers',style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,),
              const SizedBox(height: Sizes.spaceBtwSections,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()=>Get.offAll(()=>const EmailVerified()),child:
                Text('Continue',style: Theme.of(context).textTheme.bodyLarge!.apply(
                    color: Colors.white
                ),),
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwSections,),
              Text('Resend Email',style: Theme.of(context).textTheme.labelLarge,),
            ],
          ),
        ),
      ),
    );
  }
}
