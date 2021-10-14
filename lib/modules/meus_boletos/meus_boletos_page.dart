import 'package:flutter/material.dart';
import 'package:nlw_project/auth/auth.controller.dart';
import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/modules/boletoController/boletoController.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_text_style.dart';
import 'package:nlw_project/widgets/banks_list/bank_list_widget.dart';
import 'package:nlw_project/widgets/boleto_info/boleto_info_widget.dart';
import 'package:nlw_project/widgets/boleto_list/boleto_list_widget.dart';

class MeusBoletosPage extends StatefulWidget {
  const MeusBoletosPage({
    Key? key,
  }) : super(key: key);

  @override
  _MeusBoletosPageState createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<MeusBoletosPage> {
  final controller = BoletoController();
  final authController = AuthControlller();
  bool showOptions = true;
  List<BoletoModel> boletos = [];

  Future<void> refresh() async {
    List<BoletoModel> boletosAUX =
        await controller.getBoletos("bank_statement");
    setState(() {
      this.boletos = boletosAUX;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      backgroundColor: AppColors.background,
      color: AppColors.primary,
      child: FutureBuilder(
        future: controller.getBoletos("bank_statement"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            boletos = snapshot.data as List<BoletoModel>;
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height - 80 - 90,
                child: Column(
                  children: [
                    SizedBox(
                      height: 175,
                      child: Stack(
                        children: [
                          Container(
                            color: AppColors.primary,
                            height: 140,
                            width: double.maxFinite,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: BankListWidget(),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: BoletoInfoWidget(size: boletos.length),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 24, left: 24, right: 24),
                          child: Text(
                            "Meus boletos",
                            style: TextStyles.titleBoldHeading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 24),
                          child: Divider(
                              color: AppColors.stroke, thickness: 2, height: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: BoletoListWidget(
                            boletos: boletos,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
