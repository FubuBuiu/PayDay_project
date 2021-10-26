import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlw_project/auth/auth.controller.dart';
import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/models/user_model.dart';
import 'package:nlw_project/modules/barCodeScanner/barcodeScannerController.dart';
import 'package:nlw_project/modules/boletoController/boletoController.dart';
import 'package:nlw_project/modules/dark_theme/dark_theme_provider.dart';
import 'package:nlw_project/modules/login/login_controller.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_text_style.dart';
import 'package:provider/provider.dart';

class MyBottomSheet {
  final controllerScanner = BarcodeScanner();
  final controllerBoleto = BoletoController();
  final controllerAuth = AuthControlller();
  final controllerLogin = LoginController();

  void addBoletoOptions(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
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
                      Navigator.pushReplacementNamed(context, "/insert_boleto",
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
        );
      },
    );
  }

  void menuProfile(BuildContext context, UserModel user) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(1000),
          topRight: Radius.circular(1000),
        ),
      ),
      context: context,
      builder: (context) {
        final themeChange = Provider.of<DarkThemeProvider>(context);
        return Container(
          height: MediaQuery.of(context).size.height * .5,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width * .23,
                height: MediaQuery.of(context).size.width * .23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(user.photoURL!),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 30,
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .15),
                  child: Column(
                    children: [
                      SwitchListTile(
                        inactiveThumbColor: AppColors.primary,
                        activeColor: AppColors.primary,
                        inactiveTrackColor: Colors.grey,
                        secondary: Icon(
                          themeChange.darkTheme
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: AppColors.primary,
                        ),
                        title: Text(
                          "Tema ${themeChange.darkTheme ? "escuro" : "claro"}",
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary),
                        ),
                        value: themeChange.darkTheme,
                        onChanged: (bool value) {
                          themeChange.darkTheme = value;
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout_outlined,
                          color: AppColors.primary,
                        ),
                        title: Text(
                          "Sair",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        onTap: () async {
                          await controllerAuth.deleteSharedPreferencesUser();
                          controllerLogin.logout();
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/login", (route) => false);
                        },
                      ),
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () async {
                                  await controllerLogin.deleteAccount();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "/login", (route) => false);
                                },
                                child: Text(
                                  "Deletar conta",
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.delete,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void boletoOptions(BuildContext context, BoletoModel boleto) {
    final MoneyMaskedTextController moneyTextController =
        MoneyMaskedTextController(leftSymbol: "R\$ ",decimalSeparator: ",",initialValue: boleto.value!);

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 38, left: 78, right: 78, bottom: 24),
                child: Text.rich(
                  TextSpan(
                      text: "O boleto ",
                      style: GoogleFonts.lexendDeca(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,

                      ),
                      children: [
                        TextSpan(
                          text: "${boleto.name}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        TextSpan(text: " no valor de "),
                        TextSpan(
                          text: "${moneyTextController.text}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        TextSpan(text: " foi pago ?"),
                      ]),
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
                    ),
                    child: Text(
                      "Ainda não",
                      style: GoogleFonts.inter(
                          fontSize: 15, fontWeight: FontWeight.w400),
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
                    shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                        side: BorderSide(color: Colors.transparent),
                      ),
                    ),
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
                      color: AppColors.delete,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void boletoExtractOptions(BuildContext context, BoletoModel boleto) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () {
              controllerBoleto.deleteBoleto("extract", boleto);
              Navigator.pop(context);
            },
            style: ButtonStyle(
              side: MaterialStateProperty.all(BorderSide.none),
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
        );
      },
    );
  }
}
