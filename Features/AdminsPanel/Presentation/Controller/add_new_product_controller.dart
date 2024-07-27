import 'dart:io';
import 'dart:ui';

import 'package:ecommerce_app/Core/HelpingFunctions/image_picker.dart';
import 'package:ecommerce_app/Core/formatter/color_formats.dart';
import 'package:ecommerce_app/Features/ProductDetails/Presentation/ProductsBloc/products_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../Core/Entities/product.dart';

class AddNewProductController extends GetxController {
  List<File> imageFiles=[];
  GlobalKey<FormState> key=GlobalKey<FormState>();
  late List<Color> colors;
  List<Color> selectedColors=[];
  List<String> sizes = [];

  final off = TextEditingController();
  final size = TextEditingController();
  final title = TextEditingController();
  final brand = TextEditingController();
  final price = TextEditingController();
  final category = TextEditingController();
  final subCategory = TextEditingController();
  final description = TextEditingController();
  @override
  void onInit() {
    colors = ColorFormats.colorNameMap.entries.map((e) => e.value).toList();
    super.onInit();
  }
  void add()
  {
    BuildContext context=Get.context!;
    if(key.currentState!.validate())
      {
        if(selectedColors.isEmpty||sizes.isEmpty||imageFiles.isEmpty)
          {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(
                content: Text(
                    " Either colors,Sizes or Images are not selected")));
          }
        else{
          context.read<ProductsBloc>().add(AddProductsEvent(images: imageFiles, product: Product(off: off.text.trim(),subCategory: subCategory.text.trim(), category: category.text.trim(), description: description.text.trim(), sizes: sizes, colors: selectedColors.map((e) => ColorFormats.getColorString(e)).toList(), title: title.text.trim(), brand: brand.text.trim(), price: double.parse(price.text.trim()), likes: 0, id: '')));
        }
      }

  }
  String? validator(String? value)
  {

    if(value!=null&&value.isEmpty)
    {
      return "Fill this field";
    }
    else {
      return null;
    }

  }
  Future<void> pickedImages()
  async {
    File? file=await pickImage();
    if(file!=null) {
      imageFiles.add(file);
    }

  }
}
