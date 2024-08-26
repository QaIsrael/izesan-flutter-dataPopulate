import 'dart:convert';

UserData dataFromJson(String str) => UserData.fromJson(json.decode(str));

String dataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final int? userStatus;
  final bool? secured;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userStatus,
    required this.secured,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        userStatus: json["user_status"] ?? 0,
        secured: json["secured"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "user_status": userStatus,
        "secured": secured,
      };
}
