
import 'package:ecommerce_app/Core/DeviceUtils/device_utils.dart';
import 'package:ecommerce_app/Core/Entities/brand.dart';
import 'package:ecommerce_app/Core/HelpingFunctions/helper_functions.dart';
import 'package:ecommerce_app/Core/Widgets/search_field.dart';
import 'package:ecommerce_app/Features/Navigation/Controllers/storeController.dart';
import 'package:ecommerce_app/Features/ProductDetails/Presentation/all_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../Core/Entities/product.dart';
import '../../../Core/Widgets/brand_chip_with_image.dart';
import '../../../Core/Widgets/icon_button_badge.dart';
import '../../../Core/Widgets/my_rectangular_image.dart';
import '../../../Core/Widgets/my_tab_bar.dart';
import '../../../Core/constants/color_palette.dart';
import '../../../Core/constants/imageString.dart';
import '../../../Core/constants/sizes.dart';
import '../../Settings/Presentaion/cart.dart';
import '../../Widgets/navigate.dart';
import 'NavigationBlocs/navigation_bloc.dart';


class Store extends StatefulWidget {
  const Store({super.key});
  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {

 late  bool isDark;

  int items=0;
  @override
  void initState(){
    context.read<WishBloc>().add(GetItemsCount());
    super.initState();
  }
  int selected=1;
  @override
  Widget build(BuildContext context) {
    isDark=HelpingFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Store',style: Theme.of(context).textTheme.headlineMedium,),
          actions: [
            BlocListener<WishBloc,WishesState>(
              listener: (BuildContext context, state) {
                if(state is ItemsCountAchieved) {
                  items=state.count;
                  setState(() {

                  });
                }
              },
              child: IconButtonBadge(
                badgeNumber: items.toString(),

                icon: const Icon(
                  Iconsax.shopping_bag,
                  color: TColors.primary,
                ),
                onPressed: () {
                  Get.to(()=>const Cart());
                },
              ),
            )          ],
        ),
        bottomNavigationBar: bottomNavigationWidget(selected),
        body: NestedScrollView(headerSliverBuilder: (_,innerBoxIsScrolled) =>[ SliverAppBar(
          automaticallyImplyLeading: false,
          floating: true,
          bottom:   MyTabBar(tabs: const [
            Tab(
              text: 'Shoes',
            ),Tab(
              text: 'Sports',
            ),Tab(
              text: 'Electronics',
            ),Tab(
              text: 'Clothes',
            )

          ],),
          pinned: true,
          expandedHeight: 420,// this is must if not implemented gives errors
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: ListView(
              physics:  const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                const SizedBox(height: Sizes.spaceBtwSections,),
                const SearchField(),
                const SizedBox(height: Sizes.spaceBtwSections,),
                Text(
                  'Featured Brands',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
                const SizedBox(height: Sizes.spaceBtwItems,),
                 Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        BrandChipWithImage(name: 'Nike', logo: ConstantImage.nikeLogo, productsSold: '268 Products', isDark: isDark,),
                        BrandChipWithImage(name: 'Armour', logo: ConstantImage.underArmourLogo, productsSold: '98 Products', isDark: isDark,),

                      ],
                    ),

                    const SizedBox(height: Sizes.spaceBtwItems,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BrandChipWithImage(name: 'Samsung', logo: ConstantImage.samsung, productsSold: '268 Products', isDark: isDark,),
                        BrandChipWithImage(name: 'TOV', logo:ConstantImage.tov, productsSold: '268 Products', isDark: isDark,),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )], body:  TabBarView(
          children: [

            StoreTabBar(isDark: isDark, products: StoreController.products, brand: Brand(name: 'Nike', image: ConstantImage.nikeLogo),),
            StoreTabBar(isDark: isDark, products: StoreController.sport, brand: Brand(name: 'UnderArmour', image: ConstantImage.underArmourLogo),),
            StoreTabBar(isDark: isDark, products: StoreController.electronics, brand: Brand(name: 'Nike', image: ConstantImage.samsung),),
            Container(),
          ],

        ),) ,
      ),
    );
  }
}

class StoreTabBar extends StatelessWidget {
  const StoreTabBar({
    super.key,
    required this.isDark, required this.products, required this.brand,
  });
  final List<Product> products;
  final bool isDark;
  final Brand brand;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.defaultSpace),
      child: GestureDetector(
        onTap: (){

          Get.to(()=>AllProducts(products: products));
        },
        child: Column(
          children: [
          BrandChipWithImage(brandChipPadding: Sizes.sm,name: brand.name, logo: brand.image, productsSold: '268 Products', isDark: isDark, width: double.infinity,height: TDeviceUtils.getScreenHeight(context)*0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(products.length, (index) => MyRectangularImage(image: products[index].imageUrl.first,width: Sizes.iconLg*2,height: Sizes.iconLg*2,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

