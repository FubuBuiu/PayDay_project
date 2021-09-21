import 'package:flutter/material.dart';

import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/widgets/boleto_tile/boleto_extract_tile_widget.dart';

class BoletoExtractListWidget extends StatefulWidget {
  final List<BoletoModel> boletos;
  BoletoExtractListWidget({
    Key? key,
    required this.boletos,
  }) : super(key: key);

  @override
  _BoletoExtractListWidgetState createState() =>
      _BoletoExtractListWidgetState();
}

class _BoletoExtractListWidgetState extends State<BoletoExtractListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.boletos
          .map(
            (e) => BoletoExtractTileWidget(data: e),
          )
          .toList(),
    );
  }
}
