import 'package:flutter/material.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_images.dart';
import 'package:nlw_project/themes/app_text_style.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const SocialLoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.fromBorderSide(
            BorderSide(color: AppColors.stroke),
          ),
        ),
        height: 56,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(AppImages.google),
            ),
            VerticalDivider(
              color: AppColors.stroke,
              thickness: 1,
              width: 0,
            ),
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Entrar com Google",
                  style: TextStyles.buttonGray,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
