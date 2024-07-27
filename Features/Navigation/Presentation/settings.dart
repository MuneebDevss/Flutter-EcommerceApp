import 'package:ecommerce_app/Core/HelpingFunctions/helper_functions.dart';
import 'package:ecommerce_app/Core/constants/color_palette.dart';
import 'package:ecommerce_app/Features/AdminsPanel/Presentation/pages/admin_panel.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Core/Widgets/curved_edges.dart';
import '../../../Core/Widgets/main_header.dart';
import '../../../Core/Widgets/my_list_tile.dart';
import '../../../Core/constants/sizes.dart';
import '../../Settings/Presentaion/address.dart';
import '../../Settings/Presentaion/cart.dart';
import '../../Settings/Presentaion/profile.dart';
import '../../Widgets/navigate.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selected = 3;
  @override
  void initState() {
    super.initState();
  }

  bool isDark = HelpingFunctions.isDarkMode(Get.context!);
  bool geoLocationSwitchIsOn = false;
  bool safeModeSwitchIsOn = false;
  bool imageSwitchIsOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationWidget(selected),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurvedEdges(
                child: HeaderContainer(
              height: 220,
              column: Positioned(
                left: Sizes.defaultSpace,
                top: Sizes.appBarHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: Sizes.xs + 5),
                      child: Text(
                        'Account',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    MyListTile(
                      title: 'Coding With Muneeb',
                      subtitle: 'i222702@nu.edu.pk',
                      leading: const Icon(
                        Icons.account_circle,
                        size: Sizes.iconLg + 10,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            Get.to(() => const MyProfile());
                          },
                          icon: Icon(Iconsax.edit,
                              color: isDark ? TColors.white : TColors.black)),
                    ),
                  ],
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account settings',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.start,
                  ),
                  MyListTile(
                    title: 'My Address',
                    subtitle: 'Set delivery address',
                    leading: const Icon(
                      Iconsax.safe_home,
                      color: TColors.primary,
                    ),
                    onTap: () => Get.to(() => const MyAddress()),
                  ),

                  const SizedBox(
                    height: Sizes.spaceBtwItems / 3,
                  ),
                  MyListTile(
                    title: 'My Cart',
                    subtitle: 'Add and remove products or move to checkOut',
                    leading: const Icon(
                      Iconsax.shopping_cart,
                      color: TColors.primary,
                    ),
                    onTap: () => Get.to(() => const Cart()),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  MyListTile(
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                    leading: const Icon(
                      Iconsax.bag_tick,
                      color: TColors.primary,
                    ),
                    onTap: () => Get.to(() => const MyOrders()),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  MyListTile(
                      title: 'Bank Account',
                      subtitle: 'WithDraw balance to register bank account',
                      leading: const Icon(
                        Iconsax.bank,
                        color: TColors.primary,
                      )),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  MyListTile(
                      title: 'My Coupons',
                      subtitle: 'List of all Discounted Coupons',
                      leading: const Icon(
                        Iconsax.discount_circle,
                        color: TColors.primary,
                      )),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  MyListTile(
                      title: 'Notifications',
                      subtitle: 'Set any kind of notification message',
                      leading: const Icon(
                        Iconsax.notification,
                        color: TColors.primary,
                      )),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),

                  MyListTile(
                      title: 'Account Privacy',
                      subtitle: 'Manage data usage and Connected Accounts',
                      leading: const Icon(
                        Iconsax.security_user,
                        color: TColors.primary,
                      )),
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),

                  //App Setting

                  Text(
                    'App settings',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.start,
                  ),
                  MyListTile(
                      title: 'Admin Panel',
                      subtitle: 'Upload data to your cloud Firebase',
                      leading: const Icon(
                        Iconsax.document_upload,
                        color: TColors.primary,
                      ),
                    onTap: ()=>Get.to(()=> const AdminPanel()),

                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems / 3,
                  ),
                  MyListTile(
                    title: 'Geolocation',
                    subtitle: 'set recommendation based on location',
                    leading: const Icon(
                      Iconsax.location,
                      color: TColors.primary,
                    ),
                    trailing: Switch(
                      inactiveThumbColor: TColors.success,
                      value: geoLocationSwitchIsOn,
                      onChanged: (value) {
                        geoLocationSwitchIsOn = value;
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),

                  MyListTile(
                    title: 'Safe Mode',
                    subtitle: 'Search result is safe for all ages',
                    leading: const Icon(
                      Iconsax.security_user,
                      color: TColors.primary,
                    ),
                    trailing: Switch(
                      inactiveThumbColor: TColors.success,
                      value: safeModeSwitchIsOn,
                      onChanged: (value) {
                        safeModeSwitchIsOn = value;
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  MyListTile(
                    title: 'HD image Quality',
                    subtitle: 'set image quality to be seen',
                    leading: const Icon(
                      Iconsax.image,
                      color: TColors.primary,
                    ),
                    trailing: Switch(
                      inactiveThumbColor: TColors.success,
                      value: imageSwitchIsOn,
                      onChanged: (value) {
                        imageSwitchIsOn = value;
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
