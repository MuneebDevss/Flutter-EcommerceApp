import 'package:ecommerce_app/Core/HelpingFunctions/helper_functions.dart';
import 'package:ecommerce_app/Core/Widgets/my_snack_bar.dart';
import 'package:ecommerce_app/Core/Widgets/spaced_text.dart';
import 'package:ecommerce_app/Core/Controllers/product_controller.dart';
import 'package:ecommerce_app/Features/Navigation/Controllers/wishlist_controller.dart';
import 'package:ecommerce_app/Features/Navigation/Presentation/NavigationBlocs/navigation_bloc.dart';
import 'package:ecommerce_app/Features/Settings/domain/Entities/cart_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Core/DeviceUtils/device_utils.dart';
import '../../../Core/Entities/product.dart';
import '../../../Core/Widgets/MyGridViewCard.dart';
import '../../../Core/Widgets/my_add_to_cart.dart';
import '../../../Core/Widgets/my_loading.dart';
import '../../../Core/constants/color_palette.dart';
import '../../../Core/constants/imageString.dart';
import '../../../Core/constants/sizes.dart';
import '../../Settings/Presentaion/settingBloc/settings_bloc.dart';

class Sports extends StatefulWidget {
  const Sports({super.key});

  @override
  State<Sports> createState() => _SportsState();
}

class _SportsState extends State<Sports> {

  CategoryController controller =
      Get.put(CategoryController(), tag: UniqueKey().toString());
  @override
  Widget build(BuildContext context) {
    final isDark = HelpingFunctions.isDarkMode(Get.context!);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: SingleChildScrollView(
          child: BlocConsumer<SettingsBloc,SettingState>(
            builder: (BuildContext context, SettingState state) {
              if(state is LoadingState)
              {
                return const MyLoading(title: 'Adding to Cart');
              }

              return HorizontalCard(isDark: isDark, controller: controller);
            },
              listener: (BuildContext context, SettingState state) {
                if(state is AddedToCartState)
                {

                  showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.of(context).pop(true);
                      });
                      return const AlertDialog(
                        backgroundColor: TColors.success,
                        content: Text('Added to cart'),
                      );
                    },
                  );
                }
                if(state is FailedState) {
                  mySnackBar(state.message, context);
                }
              }

          ),
        ),
      ),
    );
  }
}

class HorizontalCard extends StatelessWidget {
  const HorizontalCard({
    super.key,
    required this.isDark,
    required this.controller,
  });

  final bool isDark;
  final CategoryController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishBloc,WishesState>(builder: (BuildContext context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BannerImage(
            image: ConstantImage.banner1,
          ),
          const SizedBox(
            height: Sizes.spaceBtwSections,
          ),
          SpacedText(
              firstText: 'Sports Shoes',
              secondText: 'View All',
              firstStyle: Theme.of(context).textTheme.titleLarge,
              secondStyle: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: TColors.primary)),
          const SizedBox(
            height: Sizes.spaceBtwItems,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(CategoryController.products.length, (index) {
                if (CategoryController.products[index].subCategory ==
                    'SportShoes') {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),

                    child: SubCategoryCard(isDark: isDark, details: CategoryController.products[index],index:index, controller: controller,
                    ),

                  );
                } else {
                  return const SizedBox(
                    width: 0,
                    height: 0,
                  );
                }
              }),
            ),
          ),
          const SizedBox(
            height: Sizes.spaceBtwSections,
          ),
          SpacedText(
              firstText: 'Dress Shoes',
              secondText: 'View All',
              firstStyle: Theme.of(context).textTheme.titleLarge,
              secondStyle: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: TColors.primary)),
          const SizedBox(
            height: Sizes.spaceBtwItems,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: Row(
              children: List.generate(CategoryController.products.length, (index) {
                if (CategoryController.products[index].subCategory ==
                    'DressShoes') {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SubCategoryCard(
                        isDark: isDark, details: CategoryController.products[index], index: index, controller: controller,
                      ));
                } else {
                  return const Text('');
                }
              }),
            ),
          ),
          const SizedBox(
            height: Sizes.spaceBtwSections,
          ),
        ],
      );
    },

    );
  }
}

//ignore:must_be_immutable
class SubCategoryCard extends StatefulWidget {
  const SubCategoryCard(
      {super.key,
      required this.isDark,
       required this.details, required this.index, required this.controller,
      });
  final Product details;
  final bool isDark;

  final int index;
  final CategoryController controller;
  @override
  State<SubCategoryCard> createState() => _SubCategoryCardState();
}

class _SubCategoryCardState extends State<SubCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isDark ? TColors.dark : TColors.light,
        borderRadius: BorderRadius.circular(20),
      ),
      width: TDeviceUtils.getScreenWidth(context) / 1.2,
      height: 112,
      child: Row(
        children: [
          CardImage(
            wished: WishListController.checkWish(widget.details.id),
            image: widget.details.imageUrl.first ,
            off: '${widget.details.off ?? 0}',
            imageHeight: 104,
            imageWidth: 125, productId: widget.details.id,
          ),
          const SizedBox(
            width: Sizes.sm,
          ),
          Padding(
            padding: const EdgeInsets.only(left: Sizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Sizes.sm,
                ),
                Text(
                  widget.details.title,
                  style: Theme.of(context).textTheme.labelLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: Sizes.sm / 2,
                ),
                Row(
                  children: [
                    Text(
                      widget.details.brand,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.grey),
                    ),
                    const SizedBox(
                      width: Sizes.sm,
                    ),
                    const Icon(
                      Iconsax.verify,
                      color: TColors.primary,
                      size: Sizes.md,
                    )
                  ],
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                SizedBox(
                  width: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.details.price.toString()}\$',
                            style: widget.details.off == null
                                ? Theme.of(context).textTheme.bodyMedium
                                : Theme.of(context).textTheme.labelSmall!.apply(
                                    decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          if (widget.details.off != null)
                            Text(

                              '${widget.details.price - (widget.details.price * (double.parse(widget.details.off ?? '0') / 100))}\$',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
                      ),
                      MyAddToCartButton(
                        item: CartItem(
                          id: widget.details.id,
                          brand: widget.details.brand,
                          title: widget.details.title,
                          quantity: 1,
                          size: widget.details.sizes[0],
                          color: widget.details.colors.first,
                          price: widget.details.price -
                              widget.details.price *
                                  (int.parse(widget.details.off ?? '0') / 100),
                          imageUrl: widget.details.imageUrl.first,

                        ), index:widget.index, width: widget.controller.index.contains(widget.index)?70:40, controller: widget.controller,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BannerImage extends StatelessWidget {
  const BannerImage({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.defaultSpace),
          child: Image.asset(
            image,
            width: TDeviceUtils.getScreenWidth(Get.context!) * 0.9,
            height: TDeviceUtils.getScreenHeight(Get.context!) * 0.2,
            fit: BoxFit.fitWidth,
          )),
    );
  }
}