import 'package:flutter/material.dart';

import 'package:nlw_project/modules/splash/splash_page.dart';
import 'package:nlw_project/themes/app_theme.dart';

import 'models/user_model.dart';
import 'modules/home/home_page.dart';
import 'modules/insert_boleto/insert_boleto_page.dart';
import 'modules/login/login_page.dart';

class AppWidget extends StatelessWidget {
  final bool isDarkTheme;
  AppWidget({
    Key? key,
    required this.isDarkTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      title: "Pay Flow",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.myThemeData(isDarkTheme, context),
      
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashPage(),
        "/home": (context) =>
            Home(user: ModalRoute.of(context)!.settings.arguments as UserModel),
        "/login": (context) => LoginPage(),
        "/insert_boleto": (context) => InsertBoletoPage(
            barcode: ModalRoute.of(context) != null
                ? ModalRoute.of(context)!.settings.arguments.toString()
                : null),
      },
    );
  }
}
