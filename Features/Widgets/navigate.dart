import 'package:ecommerce_app/Features/Navigation/Presentation/home_page.dart';
import 'package:ecommerce_app/Features/Navigation/Presentation/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../Navigation/Presentation/settings.dart';
import '../Navigation/Presentation/store.dart';

BottomNavigationBar bottomNavigationWidget(int selected) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: selected,
    selectedItemColor: Colors.blue,
    onTap: (value) {
      int temp=selected;
      selected=value;
      navigate(value,temp);
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Iconsax.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.store),
        label: 'Store',),
      BottomNavigationBarItem(icon: Icon(Iconsax.heart),
        label: 'Wishlist',
      ),
      BottomNavigationBarItem(icon: Icon(Iconsax.user),
        label: 'Profile',
      ),
    ],
  );
}

void navigate(int value,int selected)
{
  if(selected==value) {
    return;
  }
  else if(value==0) {

    if(selected>value) {
      Get.offAll(() => const HomePage(),transition: Transition.leftToRight,duration: const Duration(milliseconds: 300));
    }
  }
  else if(value==1) {
    if(selected>value) {
      Get.offAll(() => const Store(),transition: Transition.leftToRightWithFade,duration: const Duration(milliseconds: 300));
    } else {
      Get.offAll(() => const Store(),transition: Transition.rightToLeftWithFade,duration: const Duration(milliseconds: 300));
    }
  }
  else if(value==2) {
    if(selected>value) {
      Get.offAll(() => const Wishlist(),transition: Transition.leftToRightWithFade,duration: const Duration(milliseconds: 300));
    } else {
      Get.offAll(() => const Wishlist(),transition: Transition.rightToLeftWithFade,duration: const Duration(milliseconds: 300));
    }
  }
  else if(value==3)
  {
    if(selected>value) {
      Get.offAll(() => const Profile(),transition: Transition.leftToRightWithFade,duration: const Duration(milliseconds: 300));
    } else {
      Get.offAll(() => const Profile(),transition: Transition.rightToLeftWithFade,duration: const Duration(milliseconds: 300));
    }
  }
}
