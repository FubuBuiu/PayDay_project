import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanner {
  Future<String?> readBarcode() async {
    //----------------FUNCIONA----------------
    String? code;
    await FlutterBarcodeScanner.scanBarcode(
            "#FF0000", "Cancelar", true, ScanMode.BARCODE)
        .then((value) => code = value);
    return code;
    //----------------------------------------
  }
}
