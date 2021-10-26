import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:nlw_project/widgets/toast/toast.dart';

class BoletoTileWidget extends StatelessWidget {
  final BoletoModel data;
  const BoletoTileWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moneyInputTextController =
        MoneyMaskedTextController(decimalSeparator: ",");
    moneyInputTextController.updateValue(data.value as double);
    final bottomSheet = MyBottomSheet();
    final mySnackBar = MySnackBar();

    bool dueDateVerify() {
      var day = data.dueDate!.substring(0, 2);
      var month = data.dueDate!.substring(3, 5);
      var year = data.dueDate!.substring(6);
      var dueDate = DateTime.parse(year + month + day);
      if (dueDate.difference(DateTime.now()).inDays < 0) {
        return true;
      }
      return false;
    }

    return AnimatedCard(
      direction: AnimatedCardDirection.right,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () {
            bottomSheet.boletoOptions(context, data);
          },
          child: Container(
            padding: EdgeInsets.only(left: 10),
            height: 80,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: dueDateVerify() ? AppColors.delete : AppColors.primary,
              borderRadius: BorderRadius.circular(6),
            ),
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
                            fontWeight: FontWeight.w600,
                            color: AppColors.background
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text.rich(
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: VerticalDivider(
                          color: AppColors.background,
                          thickness: 1.5,
                          width: 5,
                        ),
                      ),
                      SizedBox(
                        height: double.maxFinite,
                        child: IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              new ClipboardData(text: data.barcode),
                            );
                            mySnackBar.showSnackBar(context);
                          },
                          icon: Icon(
                            Icons.copy_outlined,
                            color: AppColors.background,
                          ),
                        ),
                      )
                    ],
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
