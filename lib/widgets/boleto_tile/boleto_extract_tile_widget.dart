import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/widgets/bottom_sheet/bottom_sheet_widget.dart';

class BoletoExtractTileWidget extends StatelessWidget {
  final BoletoModel data;
  const BoletoExtractTileWidget({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moneyInputTextController =
        MoneyMaskedTextController(decimalSeparator: ",");
    moneyInputTextController.updateValue(data.value as double);
    final bottomSheet = MyBottomSheet();

    return AnimatedCard(
      direction: AnimatedCardDirection.right,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: InkWell(
          onTap: (){
            bottomSheet.boletoExtractOptions(context, data);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 80,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(6)),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name!,
                          style: GoogleFonts.lexendDeca(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.background,
                          ),
                        ),
                        Text(
                          "Vence em ${data.dueDate}",
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.background,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    TextSpan(
                      text: "R\$ ",
                      style: GoogleFonts.lexendDeca(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.background,
                      ),
                      children: [
                        TextSpan(
                          text: "${moneyInputTextController.text}",
                          style: GoogleFonts.lexendDeca(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.background,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
