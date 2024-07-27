import 'package:ecommerce_app/Features/Settings/Presentaion/Controllers/cart_controller.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/settingBloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../Core/Theme/custom_themes/cart_item.dart';
import '../../../Core/Widgets/circular_containers.dart';
import '../../../Core/Widgets/my_loading.dart';
import '../../../Core/Widgets/my_snack_bar.dart';
import '../../../Core/constants/color_palette.dart';
import '../../../Core/constants/sizes.dart';
import 'check_out.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: BlocConsumer<SettingsBloc, SettingState>(
          builder: (BuildContext context, SettingState state) {
            if (state is LoadingState) {
              return const MyLoading(title: 'Fetching Cart Items');
            }
            if (state is CartItemExtracted) {
              CartController.cartItems = state.items;
              return CartItemDescription(controller: controller,);
            }
            if(CartController.cartItems.isEmpty) {
              return const Center(
                child: Text(
                    'No items in the cart, add items to the cart to proceed'),
              );

            }

            return CartItemDescription(controller: controller,);

          },
          listener: (BuildContext context, SettingState state) {
            if(state is CartItemDeletedState) {
              MyLoading(title: state.message);
            }
            if (state is FailedState) {
              mySnackBar(state.message, context);
            }
          },
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
class CartItemDescription extends StatefulWidget {
  const CartItemDescription({super.key, required this.controller});
  final CartController controller;
  @override
  State<CartItemDescription> createState() => _CartItemDescriptionState();
}

class _CartItemDescriptionState extends State<CartItemDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const CheckOut());
              },
              child: Text('Checkout ${CartController.totalPrice()}'),
            ),
          ),
        ),
      body: ListView.builder(
          itemCount: CartController.cartItems.length,
          itemBuilder: (_, index) => Column(
            children: [
              MyCartItem(
                item: CartController.cartItems[index],
              ),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              Row(
                children: [
                  const SizedBox(
                      width: Sizes.appBarHeight + 10 + Sizes.xs),
                  Expanded(
                    child: Row(
                      children: [
                        CircularContainer(
                          width: Sizes.iconLg * 1.5,
                          height: Sizes.iconLg,
                          color: TColors.grey.withOpacity(0.5),
                          child: IconButton(
                            onPressed: () {
                              setState(() {});
      
                              if (CartController.cartItems[index].quantity !=
                                  0) {
                                CartController
                                    .cartItems[index].quantity--;
                              }
                              else{
                                context.read<SettingsBloc>().add(DeleteCartItems(code: CartController.cartItems[index].id, all: false));

                                CartController
                                    .cartItems.removeAt(index);
                              }
                            },
                            icon: const Icon(
                              Icons.remove,
                            ),
                          ),
                        ),
                        const SizedBox(

                          width: Sizes.spaceBtwItems,
                        ),
                        Text(
                            CartController.cartItems[index].quantity.toString()),
                        const SizedBox(
                          width: Sizes.spaceBtwItems,
                        ),
                        CircularContainer(
                          width: Sizes.iconLg * 1.5,
                          height: Sizes.iconLg,
                          color: widget.controller.isDark
                              ? Colors.blue
                              : TColors.grey,
                          child: IconButton(
                            onPressed: () {
                              setState(() {});
                              CartController
                                  .cartItems[index].quantity++;
                            },
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${widget.controller.itemsTotal(index)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
              const SizedBox(height: Sizes.spaceBtwSections)
            ],
          )),
    );
  }
}

