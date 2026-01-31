import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplaod_profile/Authentication/getx.dart';
import 'package:uplaod_profile/Screen/home.dart';
import 'package:uplaod_profile/Screen/login.dart';


class AuthUser extends StatelessWidget {
  const AuthUser({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Obx(() {
      if (authController.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      if (authController.user.value != null) {
        return const HomePage(); // already logged in
      }

      return const Login(); // not logged in
    });
  }
}
