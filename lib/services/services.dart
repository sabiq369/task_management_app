import 'package:dio/dio.dart';
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
    try {
      var response = await _dio.post(
        isLogin ? Api.login : Api.register,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (e) {
      Get.offAll(() => LoginScreen());
      showToast(msg: e.response?.data['error']);
    }
  }

  Future getUsers({required int page}) async {
    try {
      var response = await _dio.get(Api.users, queryParameters: {
        "page": page,
      });
      return response.data;
    } on DioException catch (e) {
      showToast(msg: e.response?.data['error']);
      Get.back();
    }
  }

  Future taskManagement({required int type}) async {
    /// type = 1 = Get = getTasks
    /// type = 2 = Post = createTask
    try {
      var response = type == 1
          ? await _dio.get(Api.todoList)
          : await _dio.post(Api.todoList);
      return response.data;
    } on DioException catch (e) {
      Get.offAll(() => LoginScreen());
      showToast(msg: e.response?.data['error']);
    }
  }
}
