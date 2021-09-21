import 'package:flutter/material.dart';

import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/modules/boletoController/boletoController.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_text_style.dart';
import 'package:nlw_project/widgets/boleto_info/boleto_info_widget.dart';
import 'package:nlw_project/widgets/boleto_list/boleto_extract_list_widget.dart';
import 'package:nlw_project/widgets/boleto_list/boleto_list_widget.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({
    Key? key,
  }) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final controller = BoletoController();
  List<BoletoModel> boletos = [];

  Future<void> refresh() async {
    List<BoletoModel> boletosAUX = await controller.getBoletos("extract");
    setState(() {
      this.boletos = boletosAUX;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      backgroundColor: AppColors.primary,
      color: AppColors.background,
      child: FutureBuilder(
        future: controller.getBoletos("extract"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            boletos = snapshot.data as List<BoletoModel>;
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height - 152 - 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Meus extratos",
                            style: TextStyles.titleBoldHeading,
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            "${boletos.length} pagos",
                            style: TextStyles.captionBody,
                          ),
                        ],
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
                      child: BoletoExtractListWidget(
                        boletos: boletos,
                      ),
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
