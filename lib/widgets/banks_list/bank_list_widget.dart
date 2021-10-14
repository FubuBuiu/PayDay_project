import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlw_project/modules/bankListController/bank_list_controller.dart';

import 'package:nlw_project/themes/app_colors.dart';

class BankListWidget extends StatefulWidget {
  const BankListWidget({Key? key}) : super(key: key);

  @override
  _BankListWidgetState createState() => _BankListWidgetState();
}

class _BankListWidgetState extends State<BankListWidget> {
  List<Widget> banksList = [];

  @override
  void initState() {
    super.initState();
    createContent();
  }

  createContent() async {
    List banksOnDevice = await BanksListController().getBanksAppsOnDevice();
    List<Widget> aux = [];
    if (banksOnDevice.length != 0) {
      for (var i = 0; i < banksOnDevice.length; i++) {
        if (aux.length == 0) {
          aux.add(SizedBox(
            width: 10,
          ));
        }
        aux.add(content(banksOnDevice[i]));
        aux.add(SizedBox(
          width: 10,
        ));
      }
      setState(() {
        banksList = aux;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5),
            child: Text(
              "Meus bancos",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.shape,
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            child: banksList.length != 0
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: banksList),
                  )
                : SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Nenhum banco encontrado",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget content(ApplicationWithIcon bank) {
    return InkWell(
      onTap: () {
        bank.openApp();
      },
      child: Container(
        alignment: Alignment.center,
        height: 70,
        decoration: BoxDecoration(),
        child: Image.memory(
          bank.icon,
          height: 50,
        ),
      ),
    );
  }
}
