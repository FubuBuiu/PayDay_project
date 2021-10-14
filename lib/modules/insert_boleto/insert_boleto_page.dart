import 'package:animated_card/animated_card.dart';
import 'package:animated_card/animated_card_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/modules/barcodeInformations/barcodeInformations.dart';
import 'package:nlw_project/modules/boletoController/boletoController.dart';
import 'package:nlw_project/modules/date/my_date.dart';
import 'package:nlw_project/modules/home/home_page.dart';
import 'package:nlw_project/modules/meus_boletos/meus_boletos_page.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_text_style.dart';
import 'package:nlw_project/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);
  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = BoletoController();
  final barcodeInfo = BarcodeInformations();
  final myDate = MyDate();
  final barcodeRegex = RegExp(r'^\d{47,48}$');
  final barcodeInputTextController = TextEditingController();
  final nomeController = TextEditingController();
  final moneyInputTextController = MoneyMaskedTextController(
      leftSymbol: "R\$", decimalSeparator: ",", thousandSeparator: ".");
  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");
  final focus = FocusNode();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    //------------------CASO O CAMPO BARCODE PERCA O FOCO, ELE TENTA PREENCHER O CAMPO DE VALOR E DATA------------------
    focus.addListener(
      () {
        if (!focus.hasFocus) {
          if (barcodeInputTextController.text.isNotEmpty &&
              barcodeInfo.barcodeValidator(barcodeInputTextController.text)) {
            moneyInputTextController.updateValue(double.parse(barcodeInfo
                .getValueFromBarcode(barcodeInputTextController.text)));
            dueDateInputTextController.updateText(barcodeInfo
                .getDueDateFromBarcode(barcodeInputTextController.text));
          }
        }
      },
    );
    // -----------------------------------------------------------------------------------------------------------------

    //------------------VERIFICA SE O BARCODE ESCANEADO É VÁLIDO E PREENCHE O CAMPO DO TextFormField------------------
    if (barcodeInfo.barcodeValidator(widget.barcode)) {
      barcodeInputTextController.text =
          barcodeInfo.addDvOnBarcodeNumbers(widget.barcode!);
      focus.notifyListeners();
    } else {
      barcodeInputTextController.text = "";
    }
    //----------------------------------------------------------------------------------------------------------------
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Text(
                  "Preencha os dados \ndo boleto",
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      _buildName(),
                      _buildDueDate(),
                      _buildValue(),
                      _buildBarcode(),
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryLabel: "Cancelar",
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: "Cadastrar",
        secondaryOnPressed: () async {
          if (formKey.currentState!.validate()) {
            BoletoModel boleto = BoletoModel(
              barcode: barcodeInputTextController.text,
              dueDate: dueDateInputTextController.text,
              name: nomeController.text,
              value: moneyInputTextController.numberValue,
            );
            await controller.addBoleto(boleto);
            Navigator.pop(context);
          }
        },
        enableSecondaryColor: true,
      ),
    );
  }

  Widget _buildName() {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            TextFormField(
              controller: nomeController,
              validator: (String? value) =>
                  value?.isEmpty ?? true ? "O nome não pode ser vazio" : null,
              style: TextStyles.input,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: "Nome do boleto",
                labelStyle: TextStyles.input,
                border: InputBorder.none,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(
                        Icons.description_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 0,
                        color: AppColors.stroke,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDueDate() {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            TextFormField(
              validator: (String? value) => value?.isEmpty ?? true
                  ? "A data de vencimento não pode ser vazio"
                  : !myDate.dateValidation(value!)
                      ? "Data inválida"
                      : null,
              controller: dueDateInputTextController,
              style: TextStyles.input,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: "Vencimento",
                labelStyle: TextStyles.input,
                border: InputBorder.none,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(
                        FontAwesomeIcons.timesCircle,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 0,
                        color: AppColors.stroke,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildValue() {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            TextFormField(
              validator: (String? value) {
                if (value == "R\$0,00") {
                  return "Insira um valor maior que R\$0,00";
                }
              },
              controller: moneyInputTextController,
              style: TextStyles.input,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: "Valor",
                labelStyle: TextStyles.input,
                border: InputBorder.none,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(
                        FontAwesomeIcons.wallet,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 0,
                        color: AppColors.stroke,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBarcode() {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            TextFormField(
              validator: (String? value) => value == ""
                  ? "Insira um código de barras"
                  : !barcodeRegex.hasMatch(value as String) &&
                          !barcodeInfo.barcodeValidator(value)
                      ? "Código de barras invalido"
                      : null,
              controller: barcodeInputTextController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: TextStyles.input,
              keyboardType: TextInputType.number,
              focusNode: focus,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: "Código",
                labelStyle: TextStyles.input,
                border: InputBorder.none,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(
                        FontAwesomeIcons.barcode,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 0,
                        color: AppColors.stroke,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            )
          ],
        ),
      ),
    );
  }
}
