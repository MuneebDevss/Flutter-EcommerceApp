import 'package:ecommerce_app/Core/Widgets/circular_containers.dart';
import 'package:ecommerce_app/Core/Widgets/my_snack_bar.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/Controllers/address_Controller.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/Controllers/check_out_controller.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/address.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/my_orders.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/settingBloc/settings_bloc.dart';
import 'package:ecommerce_app/Features/Settings/domain/Entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Core/Theme/custom_themes/cart_item.dart';
import '../../../Core/Widgets/spaced_text.dart';
import '../../../Core/constants/color_palette.dart';
import '../../../Core/constants/sizes.dart';
import '../domain/Entities/address.dart';
import 'Controllers/cart_controller.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  late final CheckOutController controller;
  @override
  void initState() {
    controller=CheckOutController();
      context.read<SettingsBloc>().add(GetAddressEvent(first: true));

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: ClipRRect(
            child: ElevatedButton(
              onPressed: () {
                context.read<SettingsBloc>().add(MakeOrdersEvent(item: Orders(orderState: 'Pending', shippingDate: DateTime.now().toString(), orderId: '', products: controller.productIds(CartController.cartItems))));
              },
              child: Text('Order ${CartController.totalPrice() + 12}'),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                  runSpacing: Sizes.spaceBtwItems,
                  children: List.generate(
                    CartController.cartItems.length,
                    (index) => MyCartItem(
                      item: CartController.cartItems[index],
                    ),
                  )),
              const SizedBox(height: Sizes.spaceBtwSections),
              TextFormField(
                decoration: InputDecoration(
                    label: const Text('Have a PromoCode? Enter here'),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(Sizes.sm),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Apply',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: TColors.white)),
                      ),
                    )),
              ),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: TColors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SpacedText(
                        firstText: 'SubTotal',
                        secondText: '\$${CartController.totalPrice()}',
                        firstStyle: Theme.of(context).textTheme.bodySmall,
                        secondStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                      SpacedText(
                        firstText: 'Shipping Fee',
                        secondText: '\$6',
                        firstStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .apply(fontWeightDelta: 1, color: TColors.grey),
                        secondStyle: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.grey, fontWeightDelta: 1),
                      ),
                      SpacedText(
                        firstText: 'Tax Fee',
                        secondText: '\$6',
                        firstStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .apply(fontWeightDelta: 1, color: TColors.grey),
                        secondStyle: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.grey, fontWeightDelta: 1),
                      ),
                      SpacedText(
                        firstText: 'Order Total',
                        secondText: '\$${CartController.totalPrice() + 12}',
                        firstStyle: Theme.of(context).textTheme.bodySmall,
                        secondStyle: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: Sizes.spaceBtwItems,
                      ),
                      const Divider(
                        indent: 5,
                        endIndent: 5,
                      ),
                      const SizedBox(
                        height: Sizes.spaceBtwItems,
                      ),
                      SpacedText(
                        firstText: 'Payment Method',
                        secondText: 'Change',
                        firstStyle: Theme.of(context).textTheme.titleLarge,
                        secondStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .apply(color: TColors.primary),
                      ),
                      const SizedBox(
                        height: Sizes.sm,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: Sizes.spaceBtwItems,
                          ),
                          CircularContainer(
                            width: Sizes.iconMd,
                            height: Sizes.iconMd,
                            child: Image.network(
                                'https://i.pinimg.com/564x/e4/f3/d0/e4f3d0ca67924f5a7800549fd9b2346d.jpg'),
                          ),
                          const SizedBox(
                            width: Sizes.sm,
                          ),
                          Text(
                            'PayPal',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(fontWeightDelta: 1),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: Sizes.spaceBtwItems,
                      ),
                      SpacedText(
                        firstText: 'Shipping Address',
                        secondText: 'Change',
                        firstStyle: Theme.of(context).textTheme.titleLarge,
                        secondStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .apply(color: TColors.primary),
                        onTap: () => Get.to(() => const MyAddress()),
                      ),

                      BlocConsumer<SettingsBloc,SettingState>(
                        builder: (BuildContext context, state) {
                          if(state is LoadingState) {
                            return const CircularProgressIndicator();
                          }
                          if(state is AddressAchieved) {

                            AddressController.currentAddress ==null?AddressController.currentAddress= state.addresses.first:AddressController.currentAddress=AddressController.currentAddress;


                          }
                          return AddressController.currentAddress==null? MyShippingAddress(address: AddressController.currentAddress??Address(country: '', house: '', street: '', postalCode: '', id: '', name: '', phoneNumber: ''),):MyShippingAddress(address: AddressController.currentAddress!);

                        },
                        listener: (BuildContext context, Object? state) {

                          if(state is FailedState) {
                            mySnackBar(state.message, context);
                          }
                          if(state is SuccessState)
                            {

                                context.read<SettingsBloc>().add(DeleteCartItems(code: '', all: true));

                            }
                          if(state is CartItemDeletedState){
                            CartController.cartItems=[];
                            Get.to(()=>const MyOrders());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyShippingAddress extends StatelessWidget {
  const MyShippingAddress({
    super.key, required this.address,
  });
  final Address address;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.name,
            style:
                Theme.of(context).textTheme.labelLarge!.apply(fontWeightDelta: 1),
          ),
          const SizedBox(
            height: Sizes.xs,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircularContainer(
                width: Sizes.iconMd,
                height: Sizes.iconMd,
                child: Icon(
                  Icons.call,
                  size: Sizes.iconSm,
                ),
              ),
              const SizedBox(
                width: Sizes.sm,
              ),
              Text(
                address.phoneNumber,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(fontWeightDelta: 1),
              )
            ],
          ),
          const SizedBox(
            height: Sizes.xs,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircularContainer(
                width: Sizes.iconMd,
                height: Sizes.iconMd,
                child: Icon(
                  Iconsax.location,
                  size: Sizes.iconSm,
                ),
              ),
              const SizedBox(
                width: Sizes.sm,
              ),
              Text(
                '${address.street} , ${'${address.house} , ${address.country}'}',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(fontWeightDelta: 1),
              )
            ],
          )
        ],
      ),
    );
  }
}
