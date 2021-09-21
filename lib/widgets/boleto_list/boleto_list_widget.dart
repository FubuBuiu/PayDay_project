import 'package:flutter/material.dart';

import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/widgets/boleto_tile/boleto_tile_widget.dart';

class BoletoListWidget extends StatefulWidget {
  final List<BoletoModel> boletos;
  BoletoListWidget({
    Key? key,
    required this.boletos,
  }) : super(key: key);

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.boletos
          .map(
            (e) => BoletoTileWidget(data: e),
          )
          .toList(),
    );
  }
}
