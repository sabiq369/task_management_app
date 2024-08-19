import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/auth/login/view/login.dart';
import 'package:task_management_app/common/api.dart';
import 'package:task_management_app/common/widgets/common_functions.dart';

class Services {
  final Dio _dio = Dio();
  String error = '';
  Future loginRegister(
      {required bool isLogin,
      required String email,
      required String password}) async {
    print('email: $email');
    print('password: $password');
    try {
      var response = await _dio.post(
        isLogin ? Api.login : Api.register,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        print('|||||||||||||||| response ||||||||||||||||');
        print(response.data);
        return response.data;
      }
    } on DioError catch (e) {
      showToast(msg: e.response?.data['error']);
      Get.offAll(() => LoginScreen());
    }
  }
}
