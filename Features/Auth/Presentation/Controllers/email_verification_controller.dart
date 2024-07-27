import 'dart:async';

import 'package:ecommerce_app/Features/Auth/Presentation/AuthBloc/auth_bloc.dart';
import 'package:ecommerce_app/Features/Auth/data/auth_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  Future<void> checkIfVerified() async {
    try {
      User? user = AuthRemoteDataSourceImpl.auth.currentUser;
      if (user != null) {
        await user.reload();
        if (user.emailVerified) {
          Get.offAll(EmailConfirmation());
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void reSend() {
    Get.context!.read<AuthBloc>().add(EmailConfirmation());
  }

  @override
  void onInit() {
    Get.context!.read<AuthBloc>().add(EmailConfirmation());
    Timer.periodic(const Duration(seconds: 1), (timer) {
      checkIfVerified();
    });
    super.onInit();
  }
}
