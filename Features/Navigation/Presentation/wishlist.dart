import 'package:ecommerce_app/Core/Widgets/my_loading.dart';
import 'package:ecommerce_app/Core/Widgets/my_snack_bar.dart';
import 'package:ecommerce_app/Features/Navigation/Controllers/wishlist_controller.dart';
import 'package:ecommerce_app/Features/Navigation/Presentation/NavigationBlocs/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Widgets/MyGridView.dart';
import '../../../Core/Widgets/MyGridViewCard.dart';
import '../../../Core/constants/sizes.dart';
import '../../Widgets/navigate.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  int selected = 2;
  late final WishListController controller;
  @override
  void initState() {
    controller = WishListController();
    context.read<WishBloc>().add(GetWishedProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Wishlist',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        bottomNavigationBar: bottomNavigationWidget(selected),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.md - 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Favourites',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              BlocConsumer<WishBloc, WishesState>(
                  listener: (BuildContext context, WishesState state) {
                if (state is FailureState) {
                  mySnackBar(state.message, context);
                }
                if (state is WishedProductsExtractedState) {
                  controller.wishedProducts = state.products;
                }
              }, builder: (BuildContext context, WishesState state) {
                if (state is WishLoadingState) {
                  return const MyLoading(title: 'Checking your interests');
                }
                if(WishListController.wishes.isEmpty) {
                  return const SizedBox(height: Sizes.appBarHeight*4,child: Center(child: Text('You haven\'t  Shown any interest in Products Yet!',textAlign: TextAlign.center,)));
                }
                if(state is SuccessState) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: Sizes.md - 2),
                    child: MyGridView(
                      itemBuilder: (_, index) => ThumbnailCard(
                        wished: WishListController.checkWish(
                            controller.wishedProducts[index].id),
                        details: controller.wishedProducts[index],
                      ),
                      count: controller.wishedProducts.length,
                    ),
                  );
                }
                return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.md - 2),
                    child: MyGridView(
                      itemBuilder: (_, index) => ThumbnailCard(
                        wished: WishListController.checkWish(
                            controller.wishedProducts[index].id),
                        details: controller.wishedProducts[index],
                      ),
                      count: controller.wishedProducts.length,
                    ),
                  );
              }),
            ],
          ),
        ));
  }
}
