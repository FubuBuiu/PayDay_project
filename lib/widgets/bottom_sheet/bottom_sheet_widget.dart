import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlw_project/auth/auth.controller.dart';
import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/models/user_model.dart';
import 'package:nlw_project/modules/barCodeScanner/barcodeScannerController.dart';
import 'package:nlw_project/modules/boletoController/boletoController.dart';
import 'package:nlw_project/modules/login/login_controller.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_text_style.dart';

class MyBottomSheet {
  final controllerScanner = BarcodeScanner();
  final controllerBoleto = BoletoController();
  final controllerAuth = AuthControlller();
  final controllerLogin = LoginController();

  void addBoletoOptions(BuildContext context) {
    showCupertinoModalPopup(
      barrierColor: Colors.black.withOpacity(0.7),
      context: context,
      builder: (context) {
        return Material(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 19),
                        child: Text(
                          "Escanear código",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.background,
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      final code = await controllerScanner.readBarcode();
                      if (code != "-1") {
                        Navigator.pushReplacementNamed(
                            context, "/insert_boleto",
                            arguments: code);
                      }
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 19),
                        child: Text(
                          "Digitar código",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.background,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/insert_boleto");
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void menuProfile(BuildContext context, UserModel user) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Material(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * .25,
                  height: MediaQuery.of(context).size.width * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      scale: 0.5,
                      image: NetworkImage(user.photoURL!),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * .1),
                    child: Column(
                      children: [
                        TextButton.icon(
                          icon: Icon(
                            Icons.logout_outlined,
                            color: AppColors.primary,
                            size: 25,
                          ),
                          label: Text(
                            "Sair",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          onPressed: () async {
                            await controllerAuth.deleteSharedPreferencesUser();
                            controllerLogin.logout();
                            Navigator.pushNamed(context, "/login");
                          },
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            child: Text(
                              "Deletar conta",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.delete,
                              ),
                            ),
                            onTap: () async {
                              await controllerLogin.deleteAccount();
                              Navigator.pushNamed(context, "/login");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void boletoOptions(BuildContext context, BoletoModel boleto) {
    showCupertinoModalPopup(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (context) {
        return Material(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 38, left: 78, right: 78, bottom: 24),
                  child: Text(
                    "O boleto ${boleto.name} no valor de ${boleto.value} foi pago ?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexendDeca(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.heading,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 19, horizontal: 42.5),
                        backgroundColor: AppColors.background,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.stroke),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "Ainda não",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF666666),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 19, horizontal: 64),
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "Sim",
                        style: TextStyles.buttonBackground,
                      ),
                      onPressed: () {
                        controllerBoleto.boletoPaid(boleto);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 23),
                  child: Divider(
                    thickness: 1.5,
                    height: 0,
                    color: AppColors.stroke,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {
                      controllerBoleto.deleteBoleto("bank_statement", boleto);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => AppColors.background),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * .05,
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.delete,
                      size: 17,
                      color: AppColors.delete,
                    ),
                    label: Text(
                      "Deletar boleto",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFE83F5B),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void boletoExtractOptions(BuildContext context, BoletoModel boleto) {
    showCupertinoModalPopup(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (context) {
        return Material(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                controllerBoleto.deleteBoleto("extract", boleto);
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.background),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * .05,
                  ),
                ),
              ),
              icon: Icon(
                Icons.delete,
                size: 17,
                color: AppColors.delete,
              ),
              label: Text(
                "Deletar boleto",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFE83F5B),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
