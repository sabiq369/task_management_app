class Users {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  Users({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
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
