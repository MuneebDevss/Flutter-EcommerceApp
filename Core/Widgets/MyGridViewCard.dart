import 'package:ecommerce_app/Core/HelpingFunctions/helper_functions.dart';
import 'package:ecommerce_app/Core/Widgets/my_snack_bar.dart';
import 'package:ecommerce_app/Features/Navigation/Controllers/wishlist_controller.dart';
import 'package:ecommerce_app/Features/Navigation/Domain/Entities/wished.dart';
import 'package:ecommerce_app/Features/Navigation/Presentation/NavigationBlocs/navigation_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../Features/ProductDetails/Presentation/product_details.dart';
import '../DeviceUtils/device_utils.dart';
import '../Entities/product.dart';
import '../constants/color_palette.dart';
import '../constants/sizes.dart';
import 'circular_containers.dart';

class ThumbnailCard extends StatefulWidget {
  const ThumbnailCard({
    super.key,
    required this.wished,
    this.isVerified = false, required this.details,

  });
  final bool isVerified;
  final Product details;

  final bool wished;
  @override
  State<ThumbnailCard> createState() => _ThumbnailCardState();
}

class _ThumbnailCardState extends State<ThumbnailCard> {
  late bool isDark;
  @override
  void initState(){

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    isDark=HelpingFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: (){
        Get.to(()=> ProductDetails(details: widget.details, wished: widget.wished,));
      },
      child: Container(

        width: TDeviceUtils.getScreenWidth(context) * 0.38,
        decoration: BoxDecoration(
            color: isDark?TColors.dark:TColors.light,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: TColors.grey.withOpacity(0.3),
                blurRadius: Sizes.appBarHeight,
                spreadRadius: Sizes.sm - 5,
                blurStyle: BlurStyle.solid,
                offset: const Offset(0, 2),
              ),
            ]),
        child: Column(
          children: [
            CardImage(wished: widget.wished, image: widget.details.imageUrl[0], off: widget.details.off, productId: widget.details.id,),
            const SizedBox(
              height: Sizes.md,
            ),
            Padding(
              padding: const EdgeInsets.only(left: Sizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.details.title,
                    style: Theme.of(context).textTheme.bodyLarge,
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
                    height: Sizes.sm / 2,
                  ),
                  Text(
                    '${widget.details.price.toString()}\$',
                    style: widget.details.off==null?Theme.of(context)
                        .textTheme
                        .bodyMedium
                        :Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .apply(decoration: TextDecoration.lineThrough),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  if(widget.details.off!=null)
                    Text(
                      '${widget.details.price -
                          (widget.details.price *
                              (double.parse(widget.details.off ?? '0') / 100))}\$',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
//ignore:must_be_immutable
class CardImage extends StatefulWidget {
  CardImage({super.key, required this.wished, required this.image, required this.off, this.imageWidth, this.imageHeight, required this.productId});
  bool wished;
  final String image,productId;
  final String? off;
  final double? imageWidth,imageHeight;
  @override
  State<CardImage> createState() => _CardImageState();
}
class _CardImageState extends State<CardImage> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: TColors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.image,
              width: widget.imageWidth??TDeviceUtils.getScreenWidth(context) * 0.45,
              height: widget.imageHeight??150,
              fit: BoxFit.cover,
            ),

          ),
        ),
        if(widget.off!=null)
          if(widget.off!='0')
        Positioned(
          left: Sizes.sm,
          top: Sizes.sm+4,
          child: Container(
            width: Sizes.lg * 2.5,
            height: Sizes.md * 1.5,
            decoration: BoxDecoration(
              color: Colors.yellow.withOpacity(0.9),
              borderRadius: BorderRadius.circular(Sizes.sm),
            ),
            child: Center(
              child: Text(
                '${widget.off!}% off',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .apply(color: Colors.black),
              ),
            ),
          ),
        ),
        Positioned(
          right: -2,
          top: Sizes.sm - 6,
          child: CircularContainer(
            width: 52,
            height: 52,
            color: Colors.grey.withOpacity(0.1),
            child: IconButton(

              onPressed: () {
                if(!widget.wished){
                  WishListController.wishes.add(Wished(id: 'id', userId: 'userId', productId: widget.productId));
                  context.read<WishBloc>().add(MakeWish(wish: Wished(id: '', userId: '', productId: widget.productId)));
                }
                else{
                  String id=widget.productId;
                  WishListController.removeWhereId(widget.productId);

                  context.read<WishBloc>().add(DeleteWish(id: id));
                }

              },
              icon: widget.wished
                  ? const Icon(
                CupertinoIcons.heart_fill,
                color: Colors.red,
              )
                  : const Icon(Iconsax.heart),
            ),
          ),
        ),
      ],
    );
  }
}
