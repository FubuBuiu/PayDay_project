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
      backgroundColor: AppColors.background,
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
                      padding:
                          EdgeInsets.only(top: size.height * .05, bottom: 10),
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
                                  height: 310,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white.withOpacity(0.0),
                                      Colors.white,
                                    ],
                                    stops: [0, 0.8],
                                  ),
                                ),
                                height: 310 * .28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
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
            // Positioned(
            //   bottom: size.height * .05,
            //   right: 0,
            //   left: 0,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Image.asset(AppImages.logomini),
            //       Padding(
            //         padding: EdgeInsets.only(
            //           left: 70,
            //           right: 70,
            //           top: 24,
            //         ),
            //         child: Text(
            //           "Organize seus boletos em um só lugar",
            //           style: TextStyles.titleHome,
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //       Padding(
            //         padding:
            //             const EdgeInsets.only(left: 40, right: 40, top: 40),
            //         child: SocialLoginButton(
            //           onTap: () async {
            //             controller.googleSignIn(context);
            //           },
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
