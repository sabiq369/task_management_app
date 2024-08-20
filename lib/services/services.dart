import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/auth/login/view/login.dart';
import 'package:task_management_app/auth/registration/view/register.dart';
import 'package:task_management_app/common/api.dart';
import 'package:task_management_app/common/widgets/common_functions.dart';
import 'package:task_management_app/dashboard/model/to_do_list/to_do_list_model.dart';

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
      Get.offAll(() => LoginScreen());
      showToast(msg: e.response?.data['error']);
    }
  }

  Future getUsers({required int page}) async {
    try {
      var response = await _dio.get(Api.users, queryParameters: {
        "page": page,
      });
      print('||||||| response ||||||||||');
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      showToast(msg: e.response?.data['error']);
      Get.back();
    }
  }

  Future taskManagement({required int type}) async {
    /// type = 1 = Get
    /// type = 2 = Post
    try {
      var response = type == 1
          ? await _dio.get(Api.todoList)
          : await _dio.post(Api.todoList);
      print('||||||||| response |||||||||');
      print(response.data);

      return response.data;
    } on DioError catch (e) {
      Get.offAll(() => LoginScreen());
      showToast(msg: e.response?.data['error']);
    }
  }
}
