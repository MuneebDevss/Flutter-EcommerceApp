import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Entities/product.dart';
import '../../../../Core/Widgets/my_snack_bar.dart';
import '../../../Settings/Presentaion/settingBloc/settings_bloc.dart';
import '../../../Settings/domain/Entities/cart_entity.dart';

class ProductDetailsController {
  int quantity = 0;
  int selected = -1;
  int selectedColor = -1;
  bool checkOutTapped = false;
  late String selectedColorName;
  late String selectedSize;

  void addToCart(BuildContext context, Product details) {
    if (selected == -1 || selectedColor == -1) {
      mySnackBar('Please Select at least one Color or size', context);
    } else {
      context.read<SettingsBloc>().add(AddToCartEvent(
          item: CartItem(
              id: details.id,
              brand: details.brand,
              title: details.title,
              quantity: quantity > 0 ? quantity : 1,
              size: selectedSize,
              color: selectedColorName,
              price: details.price -
                  (details.price * (double.parse(details.off ?? '0') / 100)),
              imageUrl: details.imageUrl.first)));
      checkOutTapped = true;
    }
  }
}
