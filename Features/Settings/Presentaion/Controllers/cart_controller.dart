

import 'package:ecommerce_app/Features/Settings/Presentaion/settingBloc/settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../Core/HelpingFunctions/helper_functions.dart';
import '../../domain/Entities/cart_entity.dart';

class CartController extends GetxController
{
  late final BuildContext contexts;
  late bool isDark;
  static List<CartItem> cartItems=[];

  @override
  void onInit() {
    contexts=Get.context!;
    isDark=HelpingFunctions.isDarkMode(contexts);
    contexts.read<SettingsBloc>().add(GetCartItemsEvent());
    super.onInit();
  }
  double itemsTotal(int index){
    return cartItems[index].price*cartItems[index].quantity;
  }
  static double totalPrice() {
    double total=0.0;
    for(CartItem item in cartItems){
      total+=item.price*item.quantity;
    }
    return total;
    }
}