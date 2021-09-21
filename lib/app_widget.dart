import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nlw_project/modules/splash/splash_page.dart';
import 'models/user_model.dart';
import 'modules/home/home_page.dart';
import 'modules/insert_boleto/insert_boleto_page.dart';
import 'modules/login/login_page.dart';
import 'themes/app_colors.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pay Flow",
      theme: ThemeData(
          canvasColor: Colors.transparent,
          primaryColor: AppColors.primary,
          primarySwatch: Colors.orange),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashPage(),
        "/home": (context) =>
            Home(user: ModalRoute.of(context)!.settings.arguments as UserModel),
        "/login": (context) => LoginPage(),
        // "/barcode_scanner": (context) => BarcodeScannerPage(),
        "/insert_boleto": (context) => InsertBoletoPage(
            barcode: ModalRoute.of(context) != null
                ? ModalRoute.of(context)!.settings.arguments.toString()
                : null),
      },
    );
  }
}
