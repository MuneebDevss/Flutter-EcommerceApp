import 'package:ecommerce_app/Features/Settings/domain/Entities/cart_entity.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../Widgets/my_rectangular_image.dart';
import '../../constants/sizes.dart';

class MyCartItem extends StatelessWidget {
  const MyCartItem({
    super.key, required this.item
  });
 final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyRectangularImage(image: item.imageUrl,isColored:true,width: Sizes.appBarHeight+10,height: Sizes.appBarHeight+10,),
        const SizedBox(width: Sizes.sm,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  item.brand,

                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge,
                ),
                const SizedBox(width: Sizes.sm,),
                const Icon(Iconsax.verify,color: Colors.blue,fill: 0.5,size: Sizes.iconSm,)
              ],
            ),
            Text(
              item.title,
              style:Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              children: [
                RichText(text: TextSpan(
                    text: 'Color: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                    children: [
                      TextSpan(
                        text: item.color,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge,
                      )
                    ]
                )),
                const SizedBox(width: Sizes.sm,),
                RichText(text: TextSpan(
                    text: 'Size: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                    children: [
                      TextSpan(
                        text: item.size,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge,
                      )
                    ]
                )),
              ],
            ),

          ],
        ),
      ],
    );
  }
}