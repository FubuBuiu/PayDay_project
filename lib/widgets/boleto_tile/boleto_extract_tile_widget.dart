import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/themes/app_text_style.dart';
import 'package:nlw_project/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:nlw_project/widgets/toast/toast.dart';

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
    final myToast = MyToast();

    return AnimatedCard(
      direction: AnimatedCardDirection.right,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          data.name!,
          style: TextStyles.trailingBold,
        ),
        subtitle: Text(
          "Vence em ${data.dueDate}",
          style: TextStyles.captionBody,
        ),
        trailing: Text.rich(
          TextSpan(
            text: "R\$ ",
            style: TextStyles.trailingRegular,
            children: [
              TextSpan(
                text: "${moneyInputTextController.text}",
                style: TextStyles.trailingBold,
              ),
            ],
          ),
        ),
        onTap: () {
          bottomSheet.boletoExtractOptions(context, data);
        },
      ),
    );
  }
}
