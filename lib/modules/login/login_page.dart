import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:nlw_project/modules/login/login_controller.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_images.dart';
import 'package:nlw_project/themes/app_text_style.dart';
import 'package:nlw_project/widgets/social_login/social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * .36,
              color: AppColors.primary,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: (size.height * .36) * .2, bottom: 10),
                      child: Container(
                        height: 315,
                        child: Stack(
                          children: [
                            AnimatedCard(
                              direction: AnimatedCardDirection.bottom,
                              curve: Curves.easeInOut,
                              child: Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  AppImages.person,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Image.asset(AppImages.logomini),
                    ),
                    Text(
                      "Organize seus boletos em um só lugar",
                      style: TextStyles.titleHome,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: SocialLoginButton(
                  onTap: () async {
                    controller.googleSignIn(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
