import 'package:get/get.dart';
import 'package:task_management_app/common/shared_pref.dart';
import 'package:task_management_app/dashboard/view/dashboard.dart';
import 'package:task_management_app/services/services.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  Future login(
      {required bool isLogin,
      required String email,
      required String password}) async {
    isLoading.value = true;
    var data = await Services()
        .loginRegister(isLogin: true, email: email, password: password);
    if (data != null) {
      isLoading.value = false;
      setLogin();

      Get.off(() => Dashboard());
    }
  }
}
