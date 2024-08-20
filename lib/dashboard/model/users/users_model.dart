// To parse this JSON data, do
//
//     final getUsers = getUsersFromJson(jsonString);

import 'dart:convert';

UsersModel getUsersFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String getUsersToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<Datum> data;

  UsersModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        page: json["page"] ?? 1,
        perPage: json["per_page"] ?? 1,
        total: json["total"] ?? 0,
        totalPages: json["total_pages"] ?? 0,
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  Datum({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        email: json["email"] ?? '',
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        avatar: json["avatar"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
