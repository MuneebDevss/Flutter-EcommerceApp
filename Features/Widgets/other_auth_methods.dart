import 'package:ecommerce_app/Features/Auth/Presentation/AuthBloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Core/constants/imageString.dart';
import '../../Core/constants/sizes.dart';

class OtherAuthMethods extends StatelessWidget {
  const OtherAuthMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return               Container(
      width: Sizes.buttonWidth,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(Sizes.lg)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(GoogleSignIn());
            },

            icon: Image.asset(ConstantImage.google,
                width: Sizes.iconMd, height: Sizes.iconMd),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(ConstantImage.facebook,
                width: Sizes.iconMd, height: Sizes.iconMd),
          ),
        ],
      ),
    );
  }
}
