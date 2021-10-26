import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nlw_project/auth/auth.controller.dart';
import 'package:nlw_project/models/user_model.dart';
import 'package:nlw_project/modules/boletoController/boletoController.dart';
import 'package:nlw_project/modules/notifications/notifications.dart';

class LoginController {
  final authController = AuthControlller();
  final controllerBoleto = BoletoController();
  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
    try {
      final response = await _googleSignIn.signIn();
      final user = UserModel(
          id: response!.id,
          name: response.displayName!,
          photoURL: response.photoUrl);
      authController.setUser(context, user);
    } catch (error) {
      authController.setUser(context, null);
      print(
          "---------------------USUARIO NÃO EXISTE---------------------\n${error.toString()}");
    }
  }

  Future<void> logout() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
  }

  Future<void> deleteAccount() async {
    await controllerBoleto.deleteAllBoletosUser();
    await authController.deleteSharedPreferencesUser();
    MyNotification.notifications.cancelAll();
    await logout();
  }
}
