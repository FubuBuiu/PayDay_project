import "package:flutter/material.dart";
import 'package:nlw_project/modules/home/home_page.dart';
import 'package:nlw_project/modules/login/login_page.dart';
import 'package:nlw_project/modules/splash/splash_page.dart';
import 'package:nlw_project/themes/app_colors.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pay Flow",
      theme: ThemeData(primaryColor: AppColors.primary),
      home: LoginPage(),
    );
  }
}
