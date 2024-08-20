import 'package:cached_network_image/cached_network_image.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/common/color_constants.dart';
import 'package:task_management_app/common/shared_pref.dart';
import 'package:task_management_app/common/widgets/common_functions.dart';
import 'package:task_management_app/common/widgets/extracted_text_field.dart';
import 'package:task_management_app/dashboard/controller/dashboard_controller.dart';
import 'package:task_management_app/dashboard/model/users/users_model.dart';
import 'package:task_management_app/dashboard/model/users_replaced.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final DashboardController _dashboardController =
      Get.put(DashboardController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => logOutAlert(context, 2),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Task Manager',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: ColorConstants.buttonColor,
          actions: [
            TextButton(
                onPressed: () => logOutAlert(context, 1),
                child: Text(
                  'Sign out',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(width: 10)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _dashboardController.clearTaskFields(clearAll: false);
            showDialog(
              context: context,
              builder: (context) {
                return Obx(() {
                  return Align(
                    child: Material(
                      color: Colors.transparent,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Create Task',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 20),
                                    ExtractedTextField(
                                      controller:
                                          _dashboardController.taskTitle.value,
                                      icon: const Icon(Icons.task),
                                      helperText: 'Title',
                                      hintText: 'Enter title',
                                      capitalize: true,
                                      showSuffixIcon: false,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Title field is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    ExtractedTextField(
                                      controller: _dashboardController
                                          .taskDescription.value,
                                      icon: const Icon(Icons.description),
                                      helperText: 'Description',
                                      hintText: 'Enter description',
                                      capitalize: true,
                                      showSuffixIcon: false,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Description field is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    ExtractedTextField(
                                      onTap: () => _dashboardController
                                          .pickDate(context),
                                      readOnly: true,
                                      controller: _dashboardController
                                          .taskDueDate.value,
                                      icon: const Icon(Icons.date_range),
                                      helperText: 'Due Date',
                                      hintText: 'Pick due date',
                                      showSuffixIcon: false,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Date field is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    DropdownButton<String>(
                                      value: _dashboardController
                                                  .taskPriority.value ==
                                              ''
                                          ? null
                                          : _dashboardController
                                              .taskPriority.value,
                                      hint: const Text('Choose task priority'),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: <String>[
                                        'High',
                                        'Medium',
                                        'Low',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        _dashboardController
                                            .taskPriority.value = newValue!;
                                      },
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    const Text(
                                      'Priority',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    const SizedBox(height: 20),
                                    DropdownButton<String>(
                                      value: _dashboardController
                                                  .taskStatus.value ==
                                              ''
                                          ? null
                                          : _dashboardController
                                              .taskStatus.value,
                                      hint: const Text('Choose task status'),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: <String>[
                                        'To-Do',
                                        'In Progress',
                                        'Done',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        _dashboardController.taskStatus.value =
                                            newValue!;
                                      },
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    const Text(
                                      'Status',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    const SizedBox(height: 20),
                                    DropdownButton<String>(
                                      icon: _dashboardController
                                              .usersLoading.value
                                          ? const CircularProgressIndicator(
                                              color: ColorConstants.buttonColor,
                                            )
                                          : null,
                                      value: _dashboardController
                                                  .taskAssignedUserId.value ==
                                              ''
                                          ? null
                                          : _dashboardController
                                              .taskAssignedUserId.value,
                                      hint: Text(_dashboardController
                                              .usersLoading.value
                                          ? 'Users loading...'
                                          : 'Choose user to assign task'),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: _dashboardController
                                              .usersLoading.value
                                          ? null
                                          : _dashboardController.users
                                              .map<DropdownMenuItem<String>>(
                                                  (Users value) {
                                              return DropdownMenuItem<String>(
                                                value: value.id.toString(),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: CachedNetworkImage(
                                                        imageUrl: value.avatar,
                                                        placeholder: (context,
                                                                url) =>
                                                            const CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                        width: 40,
                                                        height: 40,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                        '${value.firstName} ${value.lastName}'),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                      onChanged: (String? newValue) {
                                        _dashboardController.taskAssignedUserId
                                            .value = newValue!;

                                        print(
                                            '|||||||| selected user ||||||||||||');
                                        print(_dashboardController
                                            .taskAssignedUserId.value);
                                      },
                                    ),
                                    Divider(
                                      color: _dashboardController
                                              .assignedUserValidation.value
                                          ? Color(0xffb00020)
                                          : Colors.black,
                                    ),
                                    Text(
                                      'Assigned user',
                                      style: TextStyle(
                                          color: _dashboardController
                                                  .assignedUserValidation.value
                                              ? Color(0xffb00020)
                                              : Colors.black),
                                    ),
                                    const SizedBox(height: 20),
                                    Align(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (_dashboardController
                                                    .taskAssignedUserId.value ==
                                                "") {
                                              _dashboardController
                                                  .assignedUserValidation
                                                  .value = true;
                                            } else {
                                              _dashboardController
                                                  .assignedUserValidation
                                                  .value = false;
                                            }
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (_dashboardController
                                                      .taskAssignedUserId
                                                      .value !=
                                                  "") {
                                                _dashboardController
                                                    .createTask();
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  50),
                                              backgroundColor:
                                                  ColorConstants.buttonColor),
                                          child: _dashboardController
                                                  .createTaskLoading.value
                                              ? loadingButton(context)
                                              : const Text(
                                                  'Create Task',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            );
          },
          backgroundColor: ColorConstants.buttonColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Obx(() {
          return _dashboardController.isLoading.value
              ? InkWell(
                  onTap: () => _dashboardController.apiCall(),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.buttonColor,
                    ),
                  ),
                )
              : SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Obx(() {
                        return DragAndDropLists(
                            children: _dashboardController.lists,
                            onItemReorder: _dashboardController.onItemReorder,
                            onListReorder: _dashboardController.onListReorder);
                      }),
                      // child: Row(
                      //   children: [
                      //     Expanded(
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Text('TO DO', style: commonTextStyle(type: 1)),
                      //           SizedBox(height: 10),
                      //           Expanded(
                      //             child: ListView.builder(
                      //               shrinkWrap: true,
                      //               physics: BouncingScrollPhysics(),
                      //               itemCount: _dashboardController
                      //                   .toDoListModel.length,
                      //               itemBuilder: (context, index) {
                      //                 return _dashboardController
                      //                         .toDoListModel[index].completed
                      //                     ? taskCard(index: index, type: 1)
                      //                     : const SizedBox();
                      //               },
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(width: 10),
                      //     Expanded(
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Text('IN PROGRESS',
                      //               style: commonTextStyle(type: 2)),
                      //           SizedBox(height: 10),
                      //           Expanded(
                      //             child: ListView.builder(
                      //               shrinkWrap: true,
                      //               physics: BouncingScrollPhysics(),
                      //               itemCount: _dashboardController
                      //                   .toDoListModel.length,
                      //               itemBuilder: (context, index) {
                      //                 return _dashboardController
                      //                         .toDoListModel[index].completed
                      //                     ? taskCard(index: index, type: 2)
                      //                     : const SizedBox();
                      //               },
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(width: 10),
                      //     Expanded(
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Text('DONE', style: commonTextStyle(type: 3)),
                      //           SizedBox(height: 10),
                      //           Expanded(
                      //             child: ListView.builder(
                      //               shrinkWrap: true,
                      //               physics: BouncingScrollPhysics(),
                      //               itemCount: _dashboardController
                      //                   .toDoListModel.length,
                      //               itemBuilder: (context, index) {
                      //                 return !_dashboardController
                      //                         .toDoListModel[index].completed
                      //                     ? taskCard(index: index, type: 3)
                      //                     : const SizedBox();
                      //               },
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                );
        }),
      ),
    );
  }

  commonTextStyle({required int type}) {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: type == 1
            ? ColorConstants.toDoColor
            : type == 2
                ? ColorConstants.inProgressColor
                : ColorConstants.doneColor);
  }

  taskCard({required int index, required int type}) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.only(left: 10, right: 5, top: 15, bottom: 15),
        decoration: BoxDecoration(
            color: type == 1
                ? ColorConstants.toDoColor
                : type == 2
                    ? ColorConstants.inProgressColor
                    : ColorConstants.doneColor,
            borderRadius: BorderRadius.circular(10)),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: '${index + 1}. ', style: TextStyle(color: Colors.black)),
            TextSpan(
                text: _dashboardController.toDoListModel[index].title,
                style: TextStyle(fontStyle: FontStyle.italic))
          ]),
        ),
      ),
    );
  }
}
