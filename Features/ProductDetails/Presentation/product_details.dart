import 'package:ecommerce_app/Core/DeviceUtils/device_utils.dart';
import 'package:ecommerce_app/Core/Widgets/brand_chip_with_image.dart';
import 'package:ecommerce_app/Core/Widgets/circular_containers.dart';
import 'package:ecommerce_app/Core/Widgets/curved_edges.dart';
import 'package:ecommerce_app/Core/Widgets/my_rectangular_image.dart';
import 'package:ecommerce_app/Core/Widgets/my_snack_bar.dart';
import 'package:ecommerce_app/Core/formatter/color_formats.dart';
import 'package:ecommerce_app/Features/Navigation/Controllers/wishlist_controller.dart';
import 'package:ecommerce_app/Features/ProductDetails/Presentation/Controllers/product_details_controller.dart';
import 'package:ecommerce_app/Features/ProductDetails/Presentation/reviews.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/settingBloc/settings_bloc.dart';
import 'package:ecommerce_app/Features/Settings/domain/Entities/cart_entity.dart';
import 'package:ecommerce_app/Features/Widgets/see_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../Core/Entities/product.dart';
import '../../../Core/HelpingFunctions/helper_functions.dart';
import '../../../Core/constants/color_palette.dart';
import '../../../Core/constants/sizes.dart';
import '../../Navigation/Domain/Entities/wished.dart';
import '../../Navigation/Presentation/NavigationBlocs/navigation_bloc.dart';
import '../../Settings/Presentaion/cart.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.details, required this.wished});
  final Product details;
  final bool wished;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Product details;
  late final ProductDetailsController controller;
  @override
  void initState() {
    details = widget.details;
    controller = ProductDetailsController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = HelpingFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: AddToCartBar(
        isDark: isDark,
        controller: controller, details: details,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImageSlider(isDark: isDark, images: details.imageUrl, wished: widget.wished, productId: details.id,),
            //body
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyProductRatingAndShare(),
                  DiscountRow(
                    price: details.price,
                    off: details.off,
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  Text(
                    details.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  const MyRichText(
                    leading: 'Stock: ',
                    trailing: 'In Stock',
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),

                  BrandChipWithImage(/*logo: BrandController.brands[0].image,*/ name: details.brand, isDark: isDark,width: Sizes.buttonWidth*4,),
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  Variation(
                    isDark: isDark,
                    price: details.price,
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  Text(
                    'Colors: ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  Row(
                    children: List.generate(
                        details.colors.length,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: (){
                                  controller.selectedColor=index;
                                  controller.selectedColorName=details.colors[index]
                                  ;setState(() {

                                });},
                                child: CircularContainer(
                                  color: ColorFormats.getColorByKey(
                                          details.colors[index]) ??
                                      Colors.red,
                                  width: Sizes.iconLg,
                                  height: Sizes.iconLg,
                                  child: controller.selectedColor==index?const Icon(Icons.check,size: Sizes.iconSm,color: TColors.white,):null,
                                ),
                              ),
                            )),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  Text(
                    'Sizes: ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  Row(
                    children: List.generate(
                        details.sizes.length,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ChoiceChip(
                                  label: Text(details.sizes[index]),
                                  selected: controller.selected == index,
                                  onSelected: (isSelected) {
                                    if(isSelected){

                                      controller.selected = index;
                                      controller.selectedSize=details.sizes[index];
                                    }
                                    else
                                      {
                                        controller.selected = -1;
                                      }

                                    setState(() {});
                                  }),
                            )),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: BlocConsumer<SettingsBloc,SettingState>(
                        builder: (BuildContext context, SettingState state) {
                          if(state is LoadingState) {
                            return ElevatedButton(onPressed: (){}, child: const CircularProgressIndicator());
                          }
                          return ElevatedButton(
                              onPressed: (

                                  ) {
                                controller.addToCart(context,details);
                              }, child: const Text('Checkout'));
                        },
                        listener: (BuildContext context, SettingState state) {
                          if(state is AddedToCartState)
                            {
                              if(controller.checkOutTapped) {
                                Get.to(()=>const Cart());
                              } else{
                                mySnackBar(state.message, context);
                              }
                            }
                          if(state is FailedState){
                            mySnackBar(state.message, context);
                          }
                        },
                        
                      )),
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    details.description ?? '',
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  const Divider(
                    indent: 0,
                    endIndent: 0,
                    thickness: 0.5,
                    height: 5,
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  GestureDetector(
                    onTap:   ()=>Get.to(() => const Reviews()),
                    child: Row(
                      children: [
                        SizedBox(
                            width: TDeviceUtils.getScreenWidth(context) / 1.3,
                            child: Text(
                              'Reviews(199)',
                              style: Theme.of(context).textTheme.titleLarge,
                            )),
                        SizedBox(
                            width: Sizes.iconMd,
                            child: IconButton(
                                onPressed: () {
                                  Get.to(() => const Reviews());
                                },
                                icon: const Icon(Icons.navigate_next)))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddToCartBar extends StatefulWidget {
  const AddToCartBar({
    super.key,
    required this.isDark,
    required this.controller, required this.details,
  });

  final bool isDark;
  final ProductDetailsController controller;
  final Product details;
  @override
  State<AddToCartBar> createState() => _AddToCartBarState();
}

class _AddToCartBarState extends State<AddToCartBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Sizes.appBarHeight * 1.5,
      decoration: BoxDecoration(
          color: widget.isDark ? TColors.dark : TColors.light,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Sizes.md),
              topRight: Radius.circular(Sizes.md))),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.spaceBtwItems),
          child: Row(
            children: [
              SizedBox(
                  width: TDeviceUtils.getScreenWidth(context) / 1.7,
                  child: Row(
                    children: [
                      CircularContainer(
                        width: Sizes.iconLg,
                        height: Sizes.iconLg,
                        color: TColors.grey.withOpacity(0.5),
                        child: IconButton(
                            onPressed: () {
                              widget.controller.quantity--;
                              setState(() {});
                            },
                            icon: const Icon(Icons.remove)),
                      ),
                      const SizedBox(
                        width: Sizes.spaceBtwItems,
                      ),
                      Text(widget.controller.quantity.toString()),
                      const SizedBox(
                        width: Sizes.spaceBtwItems,
                      ),
                      CircularContainer(
                        width: Sizes.iconLg,
                        height: Sizes.iconLg,
                        color: TColors.grey,
                        child: IconButton(
                            onPressed: () {
                              widget.controller.quantity++;
                              setState(() {});
                            },
                            icon: const Icon(Icons.add)),
                      ),
                    ],
                  )),
              SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      if(widget.controller.selected==-1||widget.controller.selectedColor==-1) {
                        mySnackBar('Please Select at least one Color or size', context);
                      }
                      else {
                        context.read<SettingsBloc>().add(AddToCartEvent(item: CartItem(id: widget.details.id, brand: widget.details.brand, title: widget.details.title, quantity: widget.controller.quantity>0?widget.controller.quantity:1, size: widget.controller.selectedSize, color: widget.controller.selectedColorName, price: widget.details.price-(widget.details.price*(double.parse(widget.details.off!)/100.0)), imageUrl: widget.details.imageUrl.first)));
                      }
                    },
                    child: Center(
                        child: Text(
                      'Add to Cart',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.white),
                    )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class Variation extends StatelessWidget {
  const Variation({
    super.key,
    required this.isDark,
    required this.price,
  });
  final double price;
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? TColors.grey : TColors.light,
        borderRadius: BorderRadius.circular(Sizes.lg),
      ),
      width: double.infinity,
      height: Sizes.appBarHeight * 1.5,
      child: Row(
        children: [
          const SizedBox(
            width: Sizes.spaceBtwItems,
          ),
          Text(
            'Variation: ',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            width: Sizes.spaceBtwItems,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyRichText(
                leading: 'Price: ',
                trailing: '\$$price',
              ),
              const MyRichText(
                leading: 'Stock: ',
                trailing: 'In Stock',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MyRichText extends StatelessWidget {
  const MyRichText({
    super.key,
    required this.leading,
    required this.trailing, this.onTap,
  });
  final String leading, trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
          text: TextSpan(
              text: leading,
              style: Theme.of(context).textTheme.bodySmall,
              children: [
            TextSpan(
              text: trailing,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ])),
    );
  }
}

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({
    super.key,
    required this.isDark,
    required this.images, required this.wished, required this.productId,
  });

  final bool isDark;
  final List<String> images;
  final bool wished;
  final String productId;
  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperEdges(),
      child: Container(
        color: widget.isDark ? TColors.grey.withOpacity(0.3) : TColors.light,
        width: double.infinity,
        height: TDeviceUtils.getScreenHeight(context) * 0.465,
        child: Column(
          children: [
            AppBar(
              actions: [
                CircularContainer(
                  height: Sizes.iconLg,
                  width: Sizes.iconLg * 2,
                  child: IconButton(
                      onPressed: () {
                        if(!WishListController.checkWish(widget.productId)){
                          context.read<WishBloc>().add(MakeWish(wish: Wished(id: '', userId: '', productId: widget.productId)));
                          WishListController.wishes.add(Wished(id: 'id', userId: 'userId', productId: widget.productId));
                        }
                        else{
                          context.read<WishBloc>().add(DeleteWish(id: widget.productId));
                          WishListController.removeWhereId(widget.productId);
                        }

                      },icon:widget.wished?  const Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.red,
                  )
                      :const Icon(Iconsax.heart)),
                ),
              ],
            ),
            GestureDetector(
              onTap: ()=>Get.to(()=>ViewImage(imageUrl: widget.images[selected])),

              child: MyRectangularImage(
                  image: widget.images[selected],
                  width: Sizes.spaceBtwSections * 10,
                  height: 180,
                  circularRadius: 20,
                  isColored: false),
            ),
            const SizedBox(
              height: Sizes.spaceBtwItems,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.defaultSpace / 2.5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(
                        widget.images.length,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: GestureDetector(
                                onTap: () {
                                  selected = index;
                                  setState(() {});
                                },
                                child: MyRectangularImage(
                                  image: widget.images[index],
                                  width: 85,
                                  height: 75,
                                  isSelected: selected == index ? true : null,
                                  light: TColors.grey,
                                ),
                              ),
                            ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscountRow extends StatelessWidget {
  const DiscountRow({
    super.key,
    required this.price,
    this.off,
  });
  final double price;
  final String? off;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (off != null)
          Container(
            width: Sizes.lg * 2.4,
            height: Sizes.md * 1.5,
            decoration: BoxDecoration(
              color: Colors.yellow.withOpacity(0.7),
              borderRadius: BorderRadius.circular(Sizes.sm),
            ),
            child: Center(
              child: Text(
                '${off!}%',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .apply(color: Colors.black),
              ),
            ),
          ),
        const SizedBox(
          width: Sizes.sm,
        ),
        Text(
          '\$$price',
          style: off == null
              ? Theme.of(context).textTheme.bodyMedium
              : Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .apply(decoration: TextDecoration.lineThrough),
        ),
        const SizedBox(
          width: Sizes.sm,
        ),
        if (off != null)
          Text(
            '${price - (price * (double.parse(off ?? '0') / 100))}\$',
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}

class MyProductRatingAndShare extends StatelessWidget {
  const MyProductRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: TDeviceUtils.getScreenWidth(context) / 1.33,
          child: Row(
            children: [
              const Icon(
                Iconsax.star5,
                size: Sizes.lg,
                color: Colors.yellow,
              ),
              const SizedBox(
                width: Sizes.sm,
              ),
              Text(
                '4.2(199)',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
      ],
    );
  }
}
