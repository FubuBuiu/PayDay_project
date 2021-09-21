import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:toast/toast.dart';

class MyToast {
  showToast(BuildContext context) {
    Toast.show("Código copiado", context,
        textColor: AppColors.background,
        backgroundColor: AppColors.primary,
        gravity: Toast.CENTER,
        duration: Toast.LENGTH_LONG);
  }
}
