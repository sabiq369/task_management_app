import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/auth/login/view/login.dart';
import 'package:task_management_app/dashboard/view/dashboard.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 2500),
      () async {
        final prefs = await SharedPreferences.getInstance();
        final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
        if (isLoggedIn) {
          Get.off(() => Dashboard());
        } else {
          Get.off(() => LoginScreen());
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Task Manager',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            Lottie.asset("assets/images/splash_screen_lottie.json",
                repeat: false),
          ],
        ),
      )),
    );
  }
}
