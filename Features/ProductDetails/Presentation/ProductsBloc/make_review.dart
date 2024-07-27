
import 'package:ecommerce_app/Core/constants/sizes.dart';
import 'package:ecommerce_app/Features/ProductDetails/Presentation/Controllers/review_controller.dart';
import 'package:ecommerce_app/Features/ProductDetails/Presentation/product_details.dart';
import 'package:ecommerce_app/Features/Widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../Core/Widgets/my_rectangular_image.dart';
import '../../Data/review_entity.dart';

class MakeReview extends StatefulWidget {
  const MakeReview({super.key, required this.value});
  final  double value;
  @override
  State<MakeReview> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<MakeReview> {
  final Comment comment=ReviewController.comments[0];

  double rating=0;

  final comments=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('New Review',style: Theme.of(context).textTheme.titleLarge,),
        actions: [
          TextButton(onPressed: (){
            ReviewController.comments.add(Comment(productId: '1', userName: comment.userName, profilePicture: comment.profilePicture, comment: comments.text.trim(), uploadedAt: DateTime.now().toIso8601String(), rating: rating));
            Navigator.pop(context);
          }, child: const Text('Post')),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      MyRectangularImage(
                        image: comment.profilePicture,
                        width: Sizes.iconXlg * 0.8,
                        height: Sizes.iconXlg * 0.8,
                        circularRadius: Sizes.regularHeight,
                      ),
                      const SizedBox(
                        width: Sizes.spaceBtwItems / 2,
                      ),
                      Text(
                        comment.userName,
                        style:
                        Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.menu_outlined,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(
              height: Sizes.spaceBtwItems / 2,
            ),
            const SizedBox(
              height: Sizes.spaceBtwItems / 2,
            ),
            const MyRichText(leading: 'Reviews are public and include your account and device info', trailing: ' Learn more!'),
            const SizedBox(
              height: Sizes.spaceBtwItems ,
            ),
            Center(
              child: RatingBar(
                  ratingWidget: RatingWidget(
                      full: const Icon(
                        Iconsax.star1,
                        color: Colors.yellow,
                      ),
                      half: const Icon(
                        Iconsax.star,
                        color: Colors.yellow,
                      ),
                      empty: const Icon(
                        Iconsax.star,
                        color: Colors.yellow,
                      )),
                  onRatingUpdate: (value) {rating=value;}),
            ),
            const SizedBox(height: Sizes.spaceBtwItems,),
            InputField(label: 'Describe What you feel about our product',contentPadding: 25,controller: comments,),
          ],
        ),
      ),
    );
  }
}
