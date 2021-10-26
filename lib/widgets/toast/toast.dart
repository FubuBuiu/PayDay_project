import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nlw_project/themes/app_colors.dart';

class MySnackBar {
  showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(
          "Código copiado",
          style: TextStyle(color: AppColors.primary),textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        width: 200,
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
    );
  }
}
