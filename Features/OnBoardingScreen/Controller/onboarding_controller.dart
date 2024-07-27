import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/login_page.dart';

class OnBoardingController extends GetxController {
  static final OnBoardingController instance = Get.find<OnBoardingController>();
  final pageController = PageController();
  Rx<int> page = 0.obs;

  void updatePageIndicator(int index) => page.value = index;

  void skip() {
    pageController.jumpToPage(3);
  }

  void nextPage() {
    if (page.value == 2) {
      Get.to(()=>const LoginPage());
    } else {
      int val = page.value + 1;
      pageController.jumpToPage(val);
    }
  }

  void dotNavigation(int index) {
    pageController.jumpToPage(index);
  }
}
