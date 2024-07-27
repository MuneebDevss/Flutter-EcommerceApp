import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../Core/DeviceUtils/connectivity.dart';
import '../AuthBloc/auth_bloc.dart';

class LoginController extends GetxController
{
  final email = TextEditingController();
  final password = TextEditingController();
  final NetworkManager manager = Get.put(NetworkManager());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
  Future<void> signIn() async {
    if (await manager.isConnected() == false) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('No internet connection')),
      );
      return;
    }
    final formState = formKey.currentState;

    if ( formState!.validate()) {
      final context=Get.context!;
      context.read<AuthBloc>().add(SignInEvent(email: email.text.trim(), password: password.text.trim()));
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }
    final emailRegExp = RegExp(r'^[\w.]+@(\w+\.)+\w{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }
  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    if (!RegExp('[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter.';
    }
    return null;
  }

}