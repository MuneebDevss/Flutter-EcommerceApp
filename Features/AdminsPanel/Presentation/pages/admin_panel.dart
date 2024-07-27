import 'package:ecommerce_app/Core/Widgets/my_list_tile.dart';
import 'package:ecommerce_app/Features/AdminsPanel/Presentation/pages/add_new_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../Core/constants/sizes.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Admins Panel',style: Theme.of(context).textTheme.titleLarge,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: ListView(
          children: [

            MyListTile(title: 'Add New Product', subtitle: 'Add new product to the store',leading: const Icon(Iconsax.additem),onTap: ()=>Get.to(()=>const AddNewProduct()),),


            MyListTile(title: 'Delete Product', subtitle: 'Delete the product if it is out of the stock',leading: const Icon(Iconsax.shop_remove)),
            MyListTile(title: 'Update Info', subtitle: 'Tailor the products info according to your wish',leading: const Icon(Iconsax.record)),
          ],
        ),
      ),
    );
  }
}
