import 'package:ecommerce_app/Core/Widgets/my_list_tile.dart';
import 'package:ecommerce_app/Core/Widgets/my_rectangular_image.dart';
import 'package:ecommerce_app/Core/constants/color_palette.dart';
import 'package:ecommerce_app/Features/ProductDetails/Presentation/Controllers/review_controller.dart';
import 'package:ecommerce_app/Features/ProductDetails/Presentation/ProductsBloc/make_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../Core/constants/sizes.dart';
import '../Data/review_entity.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  late final ReviewController controller;
  @override
  void initState() {
    controller = ReviewController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reviews and ratings',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reviews and rating are verified from the users, who use the same type of Device that you use',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: Sizes.spaceBtwItems,
            ),
            AnalyticsContainer(
              entity: controller,
            ),
            const SizedBox(
              height: Sizes.spaceBtwItems,
            ),
            const SizedBox(
              height: Sizes.spaceBtwSections,
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
                  onRatingUpdate: (value) {
                    Get.to( MakeReview(value: value));
                  }),
            ),
            const SizedBox(
              height: Sizes.spaceBtwItems,
            ),
             TextButton(onPressed: (){
               Get.to(const MakeReview(value: 0));
             }, child: Text('Write review',style: Theme.of(context).textTheme.bodyMedium?.apply(color: TColors.primary),)),

            const SizedBox(
              height: Sizes.spaceBtwSections,
            ),
            Text(
              'Ratings & Reviews',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: Sizes.spaceBtwItems,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: ReviewController.comments.length,
                  itemBuilder: (_, index) {
                    Comment comment = ReviewController.comments[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Row(
                          children: [
                            RatingBarIndicator(
                              itemBuilder: (_, index) {
                                return const Icon(
                                  Iconsax.star1,
                                  color: Colors.yellow,
                                );
                              },
                              itemCount: 5,
                              itemSize: Sizes.spaceBtwItems * 1.2,
                              rating: comment.rating,
                            ),
                            const SizedBox(
                              width: Sizes.spaceBtwItems,
                            ),
                            Text(
                              comment.uploadedAt.substring(0,10),
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: Sizes.spaceBtwItems / 2,
                        ),
                        MyReadMoreText(
                          text: comment.comment,
                        ),
                        const SizedBox(
                          height: Sizes.spaceBtwItems / 2,
                        ),
                        if(comment.reply!=null)
                        MyListTile(
                          title: comment.reply?.userName ?? '',
                          subtitle: comment.reply!.comment,
                          trailing: Text(
                            comment.reply!.uploadedAt,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          dark: TColors.dark,
                          light: TColors.grey,
                        ),
                        const SizedBox(
                          height: Sizes.spaceBtwItems,
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class MyReadMoreText extends StatelessWidget {
  const MyReadMoreText({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimMode: TrimMode.Line,
      trimLines: 2,
      colorClickableText: Colors.blue,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
      moreStyle: Theme.of(context).textTheme.labelLarge,
    );
  }
}

class AnalyticsContainer extends StatelessWidget {
  const AnalyticsContainer({
    super.key,
    required this.entity,
  });
  final ReviewController entity;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  entity.getAverageRating().toString(),
                  style: const TextStyle(fontSize: Sizes.spaceBtwSections * 2),
                ),
                RatingBarIndicator(
                  itemBuilder: (_, index) {
                    return const Icon(
                      Iconsax.star1,
                      color: Colors.yellow,
                    );
                  },
                  itemCount: 5,
                  itemSize: Sizes.iconMd-5,
                  rating: entity.getAverageRating(),
                ),
                Text(
                  '${ReviewController.comments.length} reviews',
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            )),
        Expanded(
          flex: 4,
          child: Column(
            children: List.generate(
                5,
                (index) => Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              (index + 1).toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            )),
                        Expanded(
                          flex: 10,
                          child: LinearProgressIndicator(
                            value: entity.reviewList[index] == 0
                                ? 0
                                : entity
                                    .getPercentage(index),
                            minHeight: Sizes.sm,
                            borderRadius:
                                BorderRadius.circular(Sizes.borderRadiusSm),
                            backgroundColor: TColors.grey,
                            color: TColors.primary,
                          ),
                        ),
                      ],
                    )),
          ),
        ),
      ],
    );
  }
}
