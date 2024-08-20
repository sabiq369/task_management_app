// To parse this JSON data, do
//
//     final toDoListModel = toDoListModelFromJson(jsonString);

import 'dart:convert';

List<ToDoListModel> toDoListModelFromJson(String str) =>
    List<ToDoListModel>.from(
        json.decode(str).map((x) => ToDoListModel.fromJson(x)));

String toDoListModelToJson(List<ToDoListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToDoListModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  ToDoListModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory ToDoListModel.fromJson(Map<String, dynamic> json) => ToDoListModel(
        userId: json["userId"] ?? 0,
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        completed: json["completed"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
