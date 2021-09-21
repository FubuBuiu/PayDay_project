import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String? photoURL;

  UserModel({required this.id, required this.name, this.photoURL});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map["id"], name: map["name"], photoURL: map["photoURL"]);
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() =>
      {"id": id, "name": name, "photoURL": photoURL};

  String toJson() => jsonEncode(toMap());
}
