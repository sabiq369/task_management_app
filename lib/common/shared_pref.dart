import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/auth/login/view/login.dart';

void setLogin() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isLoggedIn", true);
  getPrefs("isLoggedIn");
}

getPrefs(key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key);
}

signOut() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  Get.offAll(() => LoginScreen());
}
