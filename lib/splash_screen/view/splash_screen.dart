import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management_app/auth/login/view/login.dart';
import 'package:task_management_app/dashboard/view/dashboard.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 5),
      () {
        Get.off(() => LoginScreen());
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Taskly',
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
