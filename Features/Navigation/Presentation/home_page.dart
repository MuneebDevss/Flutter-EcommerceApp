import 'package:ecommerce_app/Core/constants/imageString.dart';
import 'package:ecommerce_app/Features/Categories/Presentation/sports.dart';
import 'package:ecommerce_app/Features/Navigation/Controllers/wishlist_controller.dart';
import 'package:ecommerce_app/Features/Navigation/Presentation/NavigationBlocs/navigation_bloc.dart';

import 'package:ecommerce_app/Features/ProductDetails/Presentation/all_products.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Core/Widgets/MyGridView.dart';
import '../../../Core/Widgets/MyGridViewCard.dart';
import '../../../Core/Widgets/carousel_slider.dart';
import '../../../Core/Widgets/category_describer.dart';
import '../../../Core/Widgets/circular_containers.dart';
import '../../../Core/Widgets/curved_edges.dart';
import '../../../Core/Widgets/icon_button_badge.dart';
import '../../../Core/Widgets/main_header.dart';
import '../../../Core/Widgets/search_field.dart';
import '../../../Core/constants/color_palette.dart';
import '../../../Core/constants/sizes.dart';
import '../../Settings/Presentaion/cart.dart';
import '../../Widgets/navigate.dart';
import '../Controllers/home_page_controller.dart';
import '../Domain/Entities/categories_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    controller = HomePageController();
    context.read<WishBloc>().add(GetItemsCount());
    super.initState();
  }

  late final HomePageController controller;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    context.read<WishBloc>().add(WishesExtracted());
    return Scaffold(
      bottomNavigationBar: bottomNavigationWidget(selected),
      body: SingleChildScrollView(
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              // Body
              CarouselSliders(
                items: CategoriesItems.items,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int x = 0; x < 3; x++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.xs, vertical: Sizes.md),
                        child: CircularContainer(
                          width: Sizes.iconMd,
                          height: Sizes.iconSm / 3,
                          color: HomePageController.page.value == x
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: Sizes.spaceBtwSections / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.md - 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Products',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.start,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => AllProducts(
                              products: controller.products,
                            ));
                      },
                      child: Text('View all',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.primary)),
                    )
                  ],
                ),
              ),
              // Footer grid items
              BlocConsumer<WishBloc, WishesState>(
                listener: (BuildContext context, WishesState state) {
                  if (state is WishesExtractedState) {
                    WishListController.wishes = state.wishes;
                  }
                },
                builder: (BuildContext context, WishesState state) {
                  if (state is SuccessState) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.md - 2),
                      child: MyGridView(
                        itemBuilder: (_, index) => ThumbnailCard(
                          wished: WishListController.checkWish(
                              controller.products[index].id),
                          details: controller.products[index],
                        ),
                        count: 4,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.md - 2),
                    child: MyGridView(
                      itemBuilder: (_, index) => ThumbnailCard(
                        wished: WishListController.checkWish(
                            controller.products[index].id),
                        details: controller.products[index],
                      ),
                      count: 4,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeader extends StatefulWidget {


   const HomeHeader({
    super.key,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int items=0;

  @override
  Widget build(BuildContext context) {
    return CurvedEdges(
      child: HeaderContainer(
        column: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.defaultSpace / 2),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good day for Shopping',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .apply(color: TColors.white.withOpacity(0.7)),
                    ),
                    Text(
                      'Muneeb Ur Rehman',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: TColors.white),
                    ),
                  ],
                ),
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
                        color: TColors.white,
                      ),
                      onPressed: () {
                        Get.to(()=>const Cart());
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: Sizes.spaceBtwSections,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
              child: SearchField(),
            ),
            const SizedBox(
              height: Sizes.spaceBtwSections,
            ),
            Padding(
              padding: const EdgeInsets.only(left: Sizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Popular Categories',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: TColors.white),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CategoryDescriber(
                          icon: Image.asset(
                            ConstantImage.sports,
                            width: Sizes.iconLg * 1,
                          ),
                          descriptionText: 'Sports',
                          onTap: () => Get.to(() => const Sports()),
                        ),
                        const SizedBox(
                          width: Sizes.spaceBtwItems,
                        ),
                        CategoryDescriber(
                          icon: Image.asset(
                            ConstantImage.furniture,
                            width: Sizes.iconLg * 1,
                          ),
                          descriptionText: 'Furniture',
                        ),
                        const SizedBox(
                          width: Sizes.spaceBtwItems,
                        ),
                        CategoryDescriber(
                          icon: Image.asset(
                            ConstantImage.electronics,
                            width: Sizes.iconLg * 1,
                          ),
                          descriptionText: 'Electronic',
                        ),
                        const SizedBox(
                          width: Sizes.spaceBtwItems,
                        ),
                        CategoryDescriber(
                          icon: Image.asset(
                            ConstantImage.clothes,
                            width: Sizes.iconLg * 1,
                          ),
                          descriptionText: 'Clothes',
                        ),
                        const SizedBox(
                          width: Sizes.spaceBtwItems,
                        ),
                        CategoryDescriber(
                          icon: Image.asset(
                            ConstantImage.animals,
                            width: Sizes.iconLg * 1,
                          ),
                          descriptionText: 'Animals',
                        ),
                        const SizedBox(
                          width: Sizes.spaceBtwItems,
                        ),
                        CategoryDescriber(
                          icon: Image.asset(
                            ConstantImage.shoes,
                            width: Sizes.iconLg * 1,
                          ),
                          descriptionText: 'Shoes',
                        ),
                        const SizedBox(
                          width: Sizes.spaceBtwItems,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
