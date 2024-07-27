import 'package:ecommerce_app/Core/constants/sizes.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/Controllers/login_controller.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/signup.dart';
import 'package:ecommerce_app/Features/Navigation/Presentation/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../Widgets/input_field.dart';
import '../../Widgets/other_auth_methods.dart';
import '../../Widgets/password_field.dart';
import '../../Widgets/section_divider.dart';
import 'AuthBloc/auth_bloc.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  final controller=Get.put(LoginController(),tag: UniqueKey().toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: SingleChildScrollView(
          //header
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Sizes.appBarHeight,
                    ),
                    Text(
                      'Welcome back,',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: Sizes.sm,
                    ),
                    Text(
                      'Discover the Limitless Choices and Unmatched '
                      'Convenience',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height:
                          Sizes.spaceBtwInputFields + Sizes.spaceBtwInputFields,
                    ),
                     SizedBox(
                      width: double.infinity,
                      child: InputField(
                        controller: controller.email,
                        validate: controller.validateEmail,
                        label: 'Email', prefix: const Icon(Icons.email_outlined),),
                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwInputFields,
                    ),
                     SizedBox(

                      width: double.infinity,
                      child: PasswordField(
                        controller: controller.password,
                        validate: controller.validatePassword,
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: Sizes.xs,
                        ),
                        Checkbox(
                            value: isChecked,
                            onChanged: (val) {
                              if (val != null) {
                                isChecked = val;
                              }
                              setState(() {});
                            }),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Remember Me',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),

                              TextButton(onPressed: (){
                                Get.to(()=>const ForgotPassword());
                              }, child: Text('Forgot Password?',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: Colors.blue),))
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwSections,
                    ),
                    BlocConsumer<AuthBloc,AuthState>(
                      listener: (context,AuthState state)
                      {
                        if(state is Failure)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text(state.message)),
                          );
                        }
                        if(state is SignedIn)
                        {
                          Get.to(()=>const HomePage());
                        }
                      },
                      builder: (BuildContext context, AuthState state) {
                        if(state is BannerLoading) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(Sizes.borderRadiusMd)

                            ),
                            width: double.infinity,
                            height: kToolbarHeight,
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        }
                        return  SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.signIn();
                                }, child: const Text('Sign In')));
                      },

                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(

                            onPressed: () =>Get.to(()=>const SignUp()),
                            child: const Text('Create Account'))),
                  ],
                ),
                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),
                const SectionDivider(dividerText: 'or Sign In with',),
                //Footer
                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),
                 const OtherAuthMethods(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

