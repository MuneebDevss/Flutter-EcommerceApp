//ignore:must_be_immutable
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../DeviceUtils/device_utils.dart';
import '../constants/color_palette.dart';
import '../constants/sizes.dart';

class BrandChipWithImage extends StatelessWidget {
  const BrandChipWithImage({
    super.key,  this.logo, required this.name,  this.productsSold, this.child, this.width, this.height, this.border, required this.isDark, this.brandChipPadding,
  });
  final String? logo;
  final String name;
  final String? productsSold;
  final Widget? child;
  final double? width,height,brandChipPadding;
  final bool? border;
  final bool isDark;
  @override
  Widget build(BuildContext context)
  {
    return Container(
      width: width ?? TDeviceUtils.getScreenWidth(context)*0.42,
      height: height??TDeviceUtils.getScreenWidth(context)*0.2,
      decoration: BoxDecoration(
        border: border==null? Border.all(
          color: TColors.grey.withOpacity(0.5),
        ):const Border.fromBorderSide(BorderSide.none),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Sizes.spaceBtwItems,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              if(logo!=null)
              Padding(
                padding:  EdgeInsets.only(left:brandChipPadding??0),
                child: Image.network(logo??'',height: Sizes.md*2.7,width: Sizes.defaultSpace*2),
              ),
              const SizedBox(width: Sizes.sm,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: Theme.of(context)
                            .textTheme

                            .bodyLarge,overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: Sizes.sm,),
                      const Icon(Iconsax.verify,color: Colors.blue,fill: 0.5,size: Sizes.iconSm,)
                    ],
                  ),
                  if(productsSold!=null)
                  Text(
                    productsSold!,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!.apply(color: Colors.grey),overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields,),
          if(child!=null)
            child!,
        ],

      ),
    );
  }
}