import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management_app/auth/login/controller/login_controller.dart';
import 'package:task_management_app/auth/registration/view/register.dart';
import 'package:task_management_app/common/color_constants.dart';
import 'package:task_management_app/common/widgets/common_functions.dart';
import 'package:task_management_app/common/widgets/extracted_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Align(
                      child: Lottie.asset("assets/images/login_replaced.json"),
                    ),
                  ),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                  ExtractedTextField(
                    controller: emailController,
                    icon: Icon(CupertinoIcons.at),
                    hintText: 'Email ID',
                    textInputType: TextInputType.emailAddress,
                    showSuffixIcon: false,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email field is required';
                      }
                      final RegExp emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ExtractedTextField(
                    controller: passwordController,
                    icon: Icon(CupertinoIcons.lock),
                    hintText: 'Password',
                    showSuffixIcon: true,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password field is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  _loginController.isLoading.value
                      ? loadingButton(context)
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _loginController.login(
                                  isLogin: true,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.buttonColor,
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 50),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('New to Task Manager?'),
                      TextButton(
                        onPressed: () => Get.to(() => Register()),
                        child: Text(
                          'Register',
                          style: TextStyle(color: ColorConstants.buttonColor),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      );
    });
  }
}
