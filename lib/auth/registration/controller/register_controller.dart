import 'package:get/get.dart';
import 'package:task_management_app/dashboard/view/dashboard.dart';
import 'package:task_management_app/services/services.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  Future login({required String email, required String password}) async {
    isLoading.value = true;
    var data = await Services().login(email: email, password: password);
    print('|||||||||| data |||||||||| ');
    print(data);
    if (data != null) {
      isLoading.value = false;
      print('||||||||| Token ||||||||||');
      print(data['token'].toString());
      Get.off(() => Dashboard());
    }
  }
}
