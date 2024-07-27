import 'package:ecommerce_app/Core/Widgets/my_list_tile.dart';
import 'package:ecommerce_app/Core/Widgets/my_loading.dart';
import 'package:ecommerce_app/Core/Widgets/my_snack_bar.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/Controllers/address_Controller.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/new_address.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/settingBloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Core/constants/color_palette.dart';
import '../../../Core/constants/sizes.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  int selected=-1;
  late final AddressController controller;
  @override
  void initState(){
    controller=AddressController();
    context.read<SettingsBloc>().add(GetAddressEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.to(()=>const AddNewAddress());
      },backgroundColor: TColors.primary,
      child: const Icon(Icons.add),),
      appBar: AppBar(
        title: Text('Address',style: Theme.of(context).textTheme.titleLarge,),
        actions: [
          if(selected!=-1)
          IconButton(onPressed: (){}, icon: const Icon(Iconsax.edit)),
          if(selected!=-1)
            IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
          const SizedBox(width: Sizes.spaceBtwItems,),
        ],
      ),
      body: BlocConsumer<SettingsBloc,SettingState>(
        builder: (BuildContext context, SettingState state) {
          if(state is LoadingState) {
            return const MyLoading(title: 'Your Privacy is Our Priority');
          }

          return   ListView.builder(itemCount: controller.addresses.length,itemBuilder: (_,index)=>
              Padding(
                padding: const EdgeInsets.all(Sizes.spaceBtwItems/2),
                child: MyListTile(title: controller.addresses[index].name, subtitle: '${controller.addresses[index].phoneNumber}\n${'${controller.addresses[index].street},${'${controller.addresses[index].house},${controller.addresses[index].country}'}'}',dark:selected==index? TColors.primary:TColors.dark,light:selected==index?TColors.primary:TColors.light,trailing:selected==index?const Icon(Icons.check_circle,color: TColors.dark,):null ,onLongPressed: (){
                  selected==index?selected=-1:selected=index;
                  setState(() {
                  });
                },onTap: (){
                  selected!=-1?selected=-1:AddressController.currentAddress=controller.addresses[index];
                  mySnackBar('Selected New Address', context);

                  setState(() {
                  });
                },),
              ),
          );
        },

        listener: (BuildContext context, SettingState state) {
          if(state is AddressAchieved){
            controller.addresses=state.addresses;
          }
          if(state is FailedState) {
            mySnackBar(state.message, context);
          }
          if(state is SuccessState){
            mySnackBar(state.message, context);
          }
        },
      ),
    );

  }
}
