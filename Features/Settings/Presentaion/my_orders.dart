import 'package:ecommerce_app/Core/Widgets/my_list_tile.dart';
import 'package:ecommerce_app/Core/Widgets/my_loading.dart';
import 'package:ecommerce_app/Core/Widgets/my_snack_bar.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/Controllers/order_controller.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/settingBloc/settings_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../Core/constants/color_palette.dart';
import '../../../Core/constants/sizes.dart';
import '../../ProductDetails/Presentation/product_details.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  late final OrderController controller;
  @override
  void initState(){
    controller=OrderController();
    context.read<SettingsBloc>().add(GetOrdersEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My orders',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),

      body: Column(
        children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child:MyRichText(leading:'Your orders description will be visible to you, in case of any inconvenience ' , trailing: 'Contact Us!',onTap: ()=>mySnackBar('Number Copied',context),)
          ),
          BlocConsumer<SettingsBloc,SettingState>(
            builder: (BuildContext context, SettingState state) {

              return Expanded(
                child: ListView.builder(
                  itemCount: controller.orders.length,
                  itemBuilder: (_, int index) {
                    if(state is LoadingState) {
                      return const MyLoading(title: 'Fetching orders');
                    }
                    return  Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(Sizes.sm),
                      margin: const EdgeInsets.all(Sizes.sm),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.sm),
                          border: Border.all(
                            color: TColors.grey.withOpacity(0.5),

                          )
                      ),
                      child: Column(
                        children: [
                          MyListTile(title: controller.orders[index].orderState, subtitle: '01-Aug-2024',leading: const Icon(Icons.local_shipping_outlined),),
                          const SizedBox(height: Sizes.xs,),

                          Row(children: [
                            MyListTile(title: 'Order Tracking Id', subtitle: controller.orders[index].orderId,leading: const Icon(Iconsax.tag),useWidth: Sizes.buttonWidth * 1.25,),
                            MyListTile(title: 'Shipping Date', subtitle: controller.orders[index].shippingDate.substring(0,10),leading: const Icon(Icons.calendar_month),useWidth: Sizes.buttonWidth * 1.7,),

                          ],),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
            listener: (BuildContext context, SettingState state) {
              if(state is OrdersExtracted){
                controller.orders=state.orders;
              }
              if(state is FailedState){
                mySnackBar(state.message, context);
              }
            },

          ),
        ],
      ),
    );
  }
}
