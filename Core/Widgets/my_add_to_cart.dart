import 'package:ecommerce_app/Core/Controllers/product_controller.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/settingBloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import '../../Features/Settings/domain/Entities/cart_entity.dart';
import '../constants/color_palette.dart';
import '../constants/sizes.dart';

class MyAddToCartButton extends StatelessWidget {
    const MyAddToCartButton({
    super.key, required this.item,required this.width, required this.index, required this.controller,
  });
  final CartItem item;
  final int index;
  final double width;
  final CategoryController controller;
  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      height: 40,
      width: width,
      curve:Curves.bounceOut,
      decoration:  BoxDecoration(
          color: width==40?TColors.primary:TColors.success,
          borderRadius:width==40? const BorderRadius.only(
              topLeft: Radius.circular(Sizes.spaceBtwItems),
              bottomRight:
              Radius.circular(Sizes.spaceBtwItems)):BorderRadius.circular(20)),
      duration: const Duration(milliseconds: 150),
      child: IconButton(
            onPressed: () {
              if(width==40) {
                context.read<SettingsBloc>().add(AddToCartEvent(item: item));
                controller.index.add(index);
              }
            },
            icon: width == 40 ? const Icon(Icons.add) : const Icon(Iconsax.shop),
          ),
    );
  }
}