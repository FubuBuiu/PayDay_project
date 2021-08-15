import 'package:flutter/material.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_text_style.dart';
import 'package:nlw_project/widgets/set_label_buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: RotatedBox(
        quarterTurns: 1,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title: Text(
                "Escaneie o código de barras do boleto",
                style: TextStyles.buttonBackground,
              ),
              leading: BackButton(
                color: AppColors.background,
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: SetLabelButtons(
                primaryLabel: "Inserir código do boleto",
                primaryOnPressed: () {},
                secondaryLabel: "Adicionar da galeria",
                secondaryOnPressed: () {})),
      ),
    );
  }
}
