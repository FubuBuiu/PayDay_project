import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nlw_project/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthControlller {
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(context, "/home", arguments: user);
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString("user", user.toJson());
    return;
  }

  Future getUser() async {
    final instance = await SharedPreferences.getInstance();
    final user = instance.get("user") as String;
    return UserModel.fromJson(user);
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      setUser(
        context,
        UserModel.fromJson(json),
      );
      return;
    } else {
      setUser(context, null);
    }
  }

  Future<void> deleteSharedPreferencesUser() async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove('user');
    await instance.clear();
  }
}
