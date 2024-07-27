import 'package:ecommerce_app/Core/constants/sizes.dart';
import 'package:ecommerce_app/Features/Navigation/Controllers/wishlist_controller.dart';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Core/Entities/product.dart';
import '../../../Core/Widgets/MyGridView.dart';
import '../../../Core/Widgets/MyGridViewCard.dart';
import 'Controllers/all_products_controller.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key, required this.products});

  final List<Product> products;
  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  // The selected value for the DropdownButtonFormField

  late final AllProductsController controller;

  @override
  void initState() {
    controller = AllProductsController();
    controller.products = widget.products;
    super.initState();
  }

  // List of items for the dropdown
  final List<String> dropdownItems = ['Name', 'Price', 'Rating'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.md),

          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Iconsax.menu_15),
                  hintText: 'Sort By',
                ),
                value: controller.selectedValue,
                items: dropdownItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    controller.selectedValue = newValue;
                    controller.filter();
                  });
                },
              ),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              MyGridView(
                itemBuilder: (_, index) => ThumbnailCard(
                  wished: WishListController.checkWish(
                      widget.products[index].id),
                  details: widget.products[index],
                ),
                count: widget.products.length,
              ),
/*              BlocConsumer<ProductsBloc,ProductsState>(
                builder: (BuildContext context, ProductsState state) {
                  if(state is LoadingState) {
                    return const MyLoading(title: "Fetching you the best of our controller.products");
                  }
                  if(state is RetrievedState) {
                    return MyGridView(
                    itemBuilder: (_, index) => ThumbnailCard(
                      wished: false, details: state.controller.products[index],
                    ),
                    count: 4,
                  );
                  }
                  return const Center(child: Text('How about you check for the controller.products you like'));
                },
                listener: (BuildContext context, ProductsState state) {
                  if(state is FailureState) {
                     mySnackBar(state.message, context);
                  }
                },
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
