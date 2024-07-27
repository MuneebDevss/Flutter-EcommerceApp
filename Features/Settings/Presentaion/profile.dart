import 'package:ecommerce_app/Core/DeviceUtils/device_utils.dart';
import 'package:ecommerce_app/Core/Widgets/my_loading.dart';
import 'package:ecommerce_app/Core/Widgets/my_snack_bar.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/login_page.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/Controllers/profile_controller.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/settingBloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Core/constants/color_palette.dart';

import '../../../Core/constants/sizes.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late ProfileController controller;
  @override
  void initState(){
    controller=ProfileController();
    context.read<SettingsBloc>().add(GetProfileDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocConsumer<SettingsBloc,SettingState>(
        builder: (BuildContext context, SettingState state) {
          if(state is LoadingState)
          {
            return const Center(child: MyLoading(title: 'My Profile'));
          }

          return ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  if(controller.user.profilePicture.isNotEmpty)
                  BlocListener<SettingsBloc,SettingState>(
                    listener: (BuildContext context, SettingState state) {
                      if(state is SuccessState){
                        controller.user.profilePicture=state.message;
                      }
                    },
                    child:controller.user.profilePicture.isEmpty?                   ClipRRect(
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusXlg),
                      child: const Icon(Icons.account_circle),
                    ):ClipRRect(
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusXlg),
                      child: Image.network(
                        controller.user.profilePicture,

                        width: Sizes.iconXlg,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  TextButton(onPressed: () async =>await controller.addProfilePicture(context), child:                   Text(
                    'Change Profile Picture',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .apply(color: TColors.primary),
                  )),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  Divider(
                    indent: Sizes.defaultSpace,
                    endIndent: Sizes.defaultSpace,
                    color: TColors.grey.withOpacity(0.5),
                    thickness: 2,
                  ),
                ],
              ),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                    ),
                    Text(
                      'Profile Information',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                     MyInfoRow(
                      title: 'Name',
                      info: '${controller.user.firstName} ${controller.user.lastName}',
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: Sizes.iconLg / 1.6,
                      ),
                    ),
                    MyInfoRow(
                      title: 'UserName',
                      info: controller.user.userName,
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: Sizes.iconLg / 1.6,
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    Divider(
                      indent: 0,
                      endIndent: 0,
                      color: TColors.grey.withOpacity(0.5),
                      thickness: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                    ),
                    Text(
                      'Personal Information',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                     MyInfoRow(
                      title: 'UserId',
                      info: controller.user.id,
                      icon: const Icon(
                        Iconsax.picture_frame,
                        size: Sizes.iconLg / 1.6,
                      ),
                    ),
                     MyInfoRow(
                      title: 'Email',
                      info: controller.user.email,
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: Sizes.iconLg / 1.6,
                      ),
                    ),
                     MyInfoRow(
                      title: 'Phone no',
                      info: controller.user.phoneNumber,
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: Sizes.iconLg / 1.6,
                      ),
                    ),
                     const MyInfoRow(
                      title: 'Gender',
                      info: 'Male',
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: Sizes.iconLg / 1.6,
                      ),
                    ),
                     const MyInfoRow(
                      title: 'Date of Birth',
                      info: '10 Oct,1994',
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: Sizes.iconLg / 1.6,
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    Divider(
                      indent: 0,
                      endIndent: 0,
                      color: TColors.grey.withOpacity(0.5),
                      thickness: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(

                            title: const Text('Sign Out'),
                            content:
                            const Text('Are you Sure you want to log out'),
                            actions: [
                              TextButton(
                                  onPressed: () {

                                    context.read<SettingsBloc>().add(SignOutEvent());


                                  }, child: const Text('yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'))
                            ],
                          ));
                    },
                    child: Text(
                      'Close Account',
                      style: Theme.of(context).textTheme.labelSmall!.apply(
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          );

        },
        listener: (BuildContext context, SettingState state) {
          if(state is FailedState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if(state is ProfileRetrieved){
            controller.user=state.profile;
          }
          if(state is FailedState)
            {
              mySnackBar(state.message, context);
            }
          if(state is SignedOut)
          {
            Get.offAll(()=>const LoginPage());
          }
        },

      ),
    );
  }
}

class MyInfoRow extends StatelessWidget {
   const MyInfoRow({
    super.key,
    required this.title,
    required this.info,
    required this.icon,
  });
  final String title, info;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: TDeviceUtils.getScreenWidth(context) / 3 -
                Sizes.defaultSpace / 3,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            )),
        SizedBox(
          width: TDeviceUtils.getScreenWidth(context) / 2.3,
          child: Text(
            info,
            style: Theme.of(context).textTheme.bodyLarge,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(onPressed: () {}, icon: icon)
      ],
    );
  }
}
