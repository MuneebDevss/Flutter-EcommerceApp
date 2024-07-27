import 'package:ecommerce_app/Core/DeviceUtils/device_utils.dart';
import 'package:ecommerce_app/Core/HelpingFunctions/helper_functions.dart';
import 'package:ecommerce_app/Core/Widgets/circular_containers.dart';
import 'package:ecommerce_app/Core/constants/sizes.dart';
import 'package:ecommerce_app/Core/formatter/color_formats.dart';
import 'package:ecommerce_app/Features/ProductDetails/Presentation/ProductsBloc/products_bloc.dart';
import 'package:ecommerce_app/Features/Widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../Core/constants/color_palette.dart';
import '../Controller/add_new_product_controller.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final controller =
      Get.put(AddNewProductController(), tag: UniqueKey().toString());
  @override
  Widget build(BuildContext context) {
    bool isDark = HelpingFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product',style: Theme.of(context).textTheme.titleLarge,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: SingleChildScrollView(
          child: Form(
            key: controller.key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fill the following fields to add your new product. Fields marked with \' * \' are must to be filled',style: Theme.of(context).textTheme.bodyMedium,),
                const SizedBox(height: Sizes.spaceBtwItems,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) / 2.35,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title *',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      color: isDark
                                          ? TColors.white
                                          : TColors.primary),
                            ),
                            const SizedBox(
                              height: Sizes.spaceBtwInputFields / 2,
                            ),
                             InputField(
                              controller: controller.title,
                              validate: controller.validator,
                              label: 'Product Label',
                              prefix: const Icon(Iconsax.text_italic),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) / 2.35,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price *',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      color: isDark
                                          ? TColors.white
                                          : TColors.primary),
                            ),
                            const SizedBox(
                              height: Sizes.spaceBtwInputFields / 2,
                            ),
                             InputField(
                               controller: controller.price,
                              validate: controller.validator,
                              label: 'Price',
                              prefix: const Icon(Iconsax.dollar_circle),
                            ),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                //Description
                Text(
                  'Description ',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: isDark ? TColors.white : TColors.primary),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInputFields / 2,
                ),
                 InputField(
                  controller: controller.description,
                  label: 'Description',
                  prefix: const Icon(Iconsax.document_text),
                  maxLines: 3,
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Text(
                  'Off in %',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: isDark ? TColors.white : TColors.primary),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInputFields / 2,
                ),
                 InputField(
                  controller: controller.off,
                  label: 'Off',
                  prefix: const Icon(Iconsax.discount_circle),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Text(
                  'Your Brand Name',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: isDark ? TColors.white : TColors.primary),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInputFields/2,
                ),
                 InputField(
                  controller: controller.brand,
                  label: 'Brand',
                  validate: controller.validator,
                  prefix: const Icon(Iconsax.discount_circle),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) / 2.35,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category *',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      color: isDark
                                          ? TColors.white
                                          : TColors.primary),
                            ),
                            const SizedBox(
                              height: Sizes.spaceBtwInputFields / 2,
                            ),
                             InputField(
                              controller: controller.category,
                              validate: controller.validator,
                              label: 'Category',
                              prefix: const Icon(Iconsax.category),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) / 2.35,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SubCategory *',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      color: isDark
                                          ? TColors.white
                                          : TColors.primary),
                            ),
                            const SizedBox(
                              height: Sizes.spaceBtwInputFields / 2,
                            ),
                             InputField(
                              controller: controller.subCategory,
                              validate: controller.validator,
                              label: 'SubCategory',
                              prefix: const Icon(Iconsax.category_25),
                            ),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Text(
                  'Colors *',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: isDark ? TColors.white : TColors.primary),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInputFields / 2,
                ),
                SizedBox(
                  width: TDeviceUtils.getScreenWidth(context) -
                      Sizes.defaultSpace * 2,
                  child: DropdownButtonFormField(
                      items: controller.colors
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        TDeviceUtils.getScreenWidth(context) /
                                            2.5,
                                    height: 50,
                                    color: e,
                                  ),
                                  Text(
                                    ColorFormats.getColorString(e),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              )))
                          .toList(),
                      onChanged: (index) {
                        if (index != null) {
                          controller.selectedColors.add(index);
                          setState(() {});
                        }
                      }),
                ),
                Row(
                  children: List.generate(
                      controller.selectedColors.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(Sizes.sm),
                            child: GestureDetector(
                                onTap: () {
                                  controller.selectedColors.removeAt(index);
                                  setState(() {});
                                },
                                child: CircularContainer(
                                  width: Sizes.iconLg,
                                  height: Sizes.iconLg,
                                  color: controller.selectedColors[index],
                                )),
                          )),
                ),
                if(controller.selectedColors.isNotEmpty)
                Text(
                  'Note: Tap on the Circular Colors to remove the colors.',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!,
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Text(
                  'Sizes *',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: isDark ? TColors.white : TColors.primary),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInputFields / 2,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 290,
                      child: DropdownButtonFormField(
                          items: controller.sizes
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (index) {
                            if(index!=null) {
                            controller.sizes.remove(index);
                            setState(() {

                            });
                          }}),
                    ),
                    SizedBox(
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: const Text('Products Size'),
                                      content:
                                          const Text('Add Products new size'),
                                      actions: [
                                        InputField(
                                          controller: controller.size,
                                          label: 'New Size',
                                          prefix: const Icon(Iconsax.size),
                                        ),
                                        TextButton(
                                            onPressed: () {

                                              if (controller.size.text
                                                  .trim()
                                                  .isNotEmpty) {
                                                if(!controller.sizes.contains(controller.size.text
                                                    .trim()
                                                )) {
                                                  controller.sizes.add(controller
                                                    .size.text
                                                    .trim());
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                      content: Text(
                                                          '${controller.size.text.trim()} added')));
                                                  setState(() {

                                                  });
                                                }
                                                else{
                                                  ScaffoldMessenger.of(context)..hideCurrentSnackBar()
                                                      ..showSnackBar(SnackBar(
                                                      content: Text(
                                                          '${controller.size.text.trim()} Already in the list')));
                                                }
                                              }
                                            },
                                            child: const Text('Add')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('cancel')),
                                      ],
                                    ));
                          },
                          icon: const Icon(Iconsax.additem),
                        )),
                  ],
                ),
                const SizedBox(height: Sizes.sm,),
                if(controller.sizes.isNotEmpty)
                Text(
                  'Note: Tap on size in the drop down menu  to remove the Sizes.',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!,
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Text(
                      'Pick Images *',
                      style: Theme.of(context).textTheme.titleSmall!.apply(
                          color: isDark ? TColors.white : TColors.primary),
                    ),
                    IconButton(
                        onPressed: () async {
                          await controller.pickedImages();

                          setState(() {});
                        },
                        icon: const Icon(Iconsax.additem))
                  ],
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInputFields / 2,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                          controller.imageFiles.length,
                          (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.spaceBtwInputFields),
                                child: Stack(children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Sizes.borderRadiusMd),
                                      child: Image.file(
                                        controller.imageFiles[index],
                                        width: TDeviceUtils.getScreenWidth(
                                                context) /
                                            2,
                                        height: TDeviceUtils.getScreenHeight(
                                                context) /
                                            4,
                                        fit: BoxFit.cover,
                                      )),
                                  Positioned(
                                      right: 0,
                                      top: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            controller.imageFiles
                                                .removeAt(index);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ))),
                                ]),
                              ))),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                SizedBox(
                  width: double.infinity,
                  child: BlocConsumer<ProductsBloc,ProductsState>(
                    builder: (BuildContext context, ProductsState state) {
                      if(state is LoadingState) {
                        return ElevatedButton(onPressed: () {
                          controller.add();
                        }, child: const CircularProgressIndicator());
                      }
                      return ElevatedButton(onPressed: () {
                      controller.add();
                    }, child: const Text('Add'));},
                    listener: (BuildContext context, ProductsState state) {
                      if(state is FailureState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar( SnackBar(
                            content: Text(
                                state.message)));
                      }
                      if(state is SuccessState)
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar( SnackBar(
                            content: Text(
                                state.message)));
                      }
                    },

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
