import 'package:ecommerce_app/Core/constants/text_constants.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/AuthBloc/auth_bloc.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/Controllers/sign_up_Controller.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/email_verification.dart';
import 'package:ecommerce_app/Features/Widgets/input_field.dart';
import 'package:ecommerce_app/Features/Widgets/password_field.dart';
import 'package:ecommerce_app/Features/Widgets/section_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Core/constants/sizes.dart';
import '../../Widgets/other_auth_methods.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SignUpController myController =
      Get.put(SignUpController(), tag: UniqueKey().toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
        child: SingleChildScrollView(
          child: Form(
            key: myController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Text(
                  ConstantTexts.signUpTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Sizes.buttonWidth * 1.4,
                      child: InputField(
                          controller: myController.firstName,
                          validate: myController.firstNameValidator,
                          label: 'First Name',
                          prefix: const Icon(Iconsax.user)),
                    ),
                    const SizedBox(
                      width: Sizes.sm,
                    ),
                    SizedBox(
                      width: Sizes.buttonWidth * 1.4,
                      child: InputField(
                          validate: myController.secondNameValidator,
                          controller: myController.lastName,
                          label: 'Last Name',
                          prefix: const Icon(Iconsax.user)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                SizedBox(
                  child: InputField(
                      controller: myController.username,
                      validate: myController.validateUserName,
                      label: 'Username',
                      prefix: const Icon(
                        Iconsax.user_edit,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                SizedBox(
                  child: InputField(
                    label: 'Email',
                    prefix: const Icon(Iconsax.direct),
                    validate: myController.validateEmail,
                    controller: myController.email,
                  ),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                SizedBox(
                  child: InputField(
                      validate: myController.phoneNumber,
                      controller: myController.phone,
                      label: 'Phone',
                      prefix: const Icon(Iconsax.call)),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                SizedBox(
                  child: PasswordField(
                    validate: myController.validatePassword,
                    controller: myController.password,
                  ),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: myController.checked,
                        onChanged: (val) {
                          if (val != null) {
                            myController.checked = val;
                          }
                          setState(() {});
                        }),
                    RichText(
                        text: TextSpan(
                            text: 'I agree to ',
                            style: Theme.of(context).textTheme.labelLarge,
                            children: [
                          TextSpan(
                            text: 'Privacy Policy',
                            style:
                                Theme.of(context).textTheme.labelLarge!.apply(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Terms of Use',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue),
                          )
                        ])),
                  ],
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (BuildContext context, AuthState state) {
                    if (state is UserRegistered) {
                      Get.to(() => EmailVerifcation(email: state.email));
                    }

                    if (state is Failure) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          elevation: 3,
                          showCloseIcon: true,
                          closeIconColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                          content: Text(

                            state.message,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: myController.validateAll,
                      child: Text(
                        'Create Account',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),
                const SectionDivider(dividerText: 'or Sign Up with'),
                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OtherAuthMethods(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
