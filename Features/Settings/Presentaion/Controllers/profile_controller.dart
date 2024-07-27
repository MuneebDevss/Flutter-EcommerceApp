import 'dart:io';

import 'package:ecommerce_app/Core/Entities/user.dart';
import 'package:ecommerce_app/Core/HelpingFunctions/image_picker.dart';
import 'package:ecommerce_app/Features/Settings/Presentaion/settingBloc/settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileController
{
  late UserModel user=UserModel('id', firstName: 'firstName', lastName: 'lastName', email: 'email', userName: 'userName', phoneNumber: 'phoneNumber', profilePicture: 'profilePicture');
  Future<void> addProfilePicture(BuildContext context)async{

    File? file=await pickImage();
    if(file!=null) {
      context.read<SettingsBloc>().add(AddProfilePicture(image: file));
    }
  }
}