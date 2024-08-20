import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/common/color_constants.dart';
import 'package:task_management_app/dashboard/model/to_do_list/to_do_list_model.dart';
import 'package:task_management_app/dashboard/model/users/users_model.dart';
import 'package:task_management_app/dashboard/model/users_replaced.dart';
import 'package:task_management_app/services/services.dart';

class DashboardController extends GetxController {
  // UsersModel? usersModel;
  List<ToDoListModel> toDoListModel = [];
  var lists = <DragAndDropList>[].obs;
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
        // usersModel = UsersModel.fromJson(data);
        var newUsers = data['data']
            .map<Users>((userJson) => Users.fromJson(userJson))
            .toList();
        users.addAll(newUsers);
        print('|||||||| userss |||||||||');
        print(data["data"]);
        totalPage.value = data["total_pages"];
        // totalPage.value = usersModel!.totalPages;
        currentPage++;
        usersLoading.value = false;
      }
    }
  }

  apiCall() async {
    isLoading.value = true;
    var data = await Services().taskManagement(type: 1);
    if (data != null) {
      print('|||||||| here is the error ||||||||');
      List<dynamic> tasks = data;
      toDoListModel =
          tasks.map((json) => ToDoListModel.fromJson(json)).toList();
      lists.value = List.generate(3, (listIndex) {
        return DragAndDropList(
          header: Container(
            padding: EdgeInsets.all(8),
            color: Colors.blue,
            child: Text(
                listIndex == 0
                    ? 'TO DO'
                    : listIndex == 1
                        ? 'IN PROGRESS'
                        : 'DONE',
                style: TextStyle(color: Colors.white)),
          ),
          children: List.generate(toDoListModel.length, (childIndex) {
            return DragAndDropItem(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding:
                      EdgeInsets.only(left: 10, right: 5, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                      color: listIndex == 0
                          ? ColorConstants.toDoColor
                          : listIndex == 1
                              ? ColorConstants.inProgressColor
                              : ColorConstants.doneColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: '${childIndex + 1}. ',
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: toDoListModel[childIndex].title,
                          style: TextStyle(fontStyle: FontStyle.italic))
                    ]),
                  ),
                ),
              ),
            );
          }),
        );
      });
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
    }
  }

  void onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    var movedItem = lists[oldListIndex].children.removeAt(oldItemIndex);
    lists[newListIndex].children.insert(newItemIndex, movedItem);
  }

  void onListReorder(int oldListIndex, int newListIndex) {
    var movedList = lists.removeAt(oldListIndex);
    lists.insert(newListIndex, movedList);
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
