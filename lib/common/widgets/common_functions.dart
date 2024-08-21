import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:task_management_app/common/color_constants.dart';
import 'package:task_management_app/common/shared_pref.dart';

showToast({required String msg}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}

loadingButton(context) {
  return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.buttonColor,
        fixedSize: Size(MediaQuery.of(context).size.width, 50),
      ),
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.white,
          size: 40,
        ),
      ));
}

logOutAlert(context, type) {
  showDialog(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Align(
          child: Material(
            color: Colors.transparent,
            child: Wrap(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        type == 1 ? 'Sign out' : 'Exit App',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      Text(
                          type == 1
                              ? 'Are you sure you want to sign out?'
                              : 'Are you sure you want to exit app?',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                type == 1 ? signOut() : SystemNavigator.pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size.fromHeight(45),
                                  backgroundColor: ColorConstants.buttonColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                type == 1 ? 'Sign out' : 'Exit',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('cancel',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
