import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/common/color_constants.dart';
import 'package:task_management_app/common/widgets/common_functions.dart';
import 'package:task_management_app/dashboard/model/to_do_list/to_do_list_model.dart';
import 'package:task_management_app/dashboard/model/users_replaced.dart';
import 'package:task_management_app/services/services.dart';

class DashboardController extends GetxController {
  List<ToDoListModel> toDoListModel = [];
  RxBool isLoading = false.obs,
      usersLoading = false.obs,
      createTaskLoading = false.obs,
      assignedUserValidation = false.obs;
  final Rx<TextEditingController> taskTitle = TextEditingController().obs,
      taskDescription = TextEditingController().obs,
      taskDueDate = TextEditingController().obs;
  RxString taskPriority = 'Low'.obs,
      taskStatus = 'To-Do'.obs,
      taskAssignedUserId = ''.obs;
  RxInt userId = 0.obs, currentPage = 1.obs, totalPage = 1.obs;

  var users = <Users>[].obs;

  pickDate(context) async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (datePicked != null) {
      taskDueDate.value.text = DateFormat('dd-MM-yyyy').format(datePicked);
    }
  }

  clearTaskFields({required bool clearAll}) {
    users.clear();
    taskAssignedUserId.value = '';
    currentPage.value = 1;
    totalPage.value = 1;
    getUsers();
    assignedUserValidation.value = false;
    if (clearAll) {
      taskTitle.value.clear();
      taskDescription.value.clear();
      taskDueDate.value.clear();
    }
  }

  pickPriority() {
    DropdownButton<String>(
      value: 'Option 1',
      items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {},
    );
  }

  getUsers() async {
    usersLoading.value = true;
    while (currentPage <= totalPage.value) {
      var data = await Services().getUsers(page: currentPage.value);
      if (data != null) {
        var newUsers = data['data']
            .map<Users>((userJson) => Users.fromJson(userJson))
            .toList();
        users.addAll(newUsers);
        totalPage.value = data["total_pages"];
        currentPage++;
        usersLoading.value = false;
      }
    }
  }

  apiCall() async {
    isLoading.value = true;
    var data = await Services().taskManagement(type: 1);
    if (data != null) {
      List<dynamic> tasks = data;
      toDoListModel =
          tasks.map((json) => ToDoListModel.fromJson(json)).toList();
      isLoading.value = false;
    }
  }

  createTask() async {
    createTaskLoading.value = true;
    var data = await Services().taskManagement(type: 2);
    if (data != null) {
      Get.back();
      createTaskLoading.value = false;
      clearTaskFields(clearAll: true);
      showToast(msg: 'New task created successfully');
    }
  }

  commonTextStyle({required int index}) {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: index == 1
            ? ColorConstants.toDoColor
            : index == 2
                ? ColorConstants.inProgressColor
                : ColorConstants.doneColor);
  }

  @override
  void onInit() {
    apiCall();
    super.onInit();
  }
}
