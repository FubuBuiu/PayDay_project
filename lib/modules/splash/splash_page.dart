import "package:flutter/material.dart";
import 'package:nlw_project/auth/auth.controller.dart';
import 'package:nlw_project/themes/app_images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = AuthControlller();
    authController.currentUser(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Image.asset(AppImages.union),
          ),
          Center(
            child: Image.asset(AppImages.logoFull),
          ),
        ],
      ),
    );
  }
}
