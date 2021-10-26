class BarcodeInformations {
  //----------------CÁLCULO PARA ENCONTRAR O DÍGITO VERIFICADOR DE CADA CAMPO DO BARCODE----------------
  addDvOnBarcodeNumbers(String barcodeNumbers) {
    if (barcodeNumbers.length == 44) {
      if (barcodeNumbers[0] == "8") {
        var field1 = barcodeNumbers.substring(0, 11);
        var field2 = barcodeNumbers.substring(11, 22);
        var field3 = barcodeNumbers.substring(22, 33);
        var field4 = barcodeNumbers.substring(33);
        var fieldsList = [field1, field2, field3, field4];
        String completeBarcode = "";
        for (var field in fieldsList.reversed) {
          var listaNumeros = field.split("").reversed;
          var soma = 0;
          for (var i = 0; i < listaNumeros.length; i++) {
            if (i % 2 == 0) {
              var numero = int.parse(listaNumeros.elementAt(i)) * 2;
              if (numero.toString().length > 1) {
                soma += int.parse(numero.toString()[0]) +
                    int.parse(numero.toString()[1]);
              } else {
                soma += int.parse(listaNumeros.elementAt(i)) * 2;
              }
            } else {
              soma += int.parse(listaNumeros.elementAt(i));
            }
          }
          if (soma % 10 == 0) {
            //DV é 0
            completeBarcode = field + "0" + completeBarcode;
          } else {
            // DV é 10 - (soma%10)
            completeBarcode = field + "${10 - (soma % 10)}" + completeBarcode;
          }
        }
        return completeBarcode;
      } else {
        var field1 =
            barcodeNumbers.substring(0, 4) + barcodeNumbers.substring(19, 24);
        var field2 = barcodeNumbers.substring(24, 34);
        var field3 = barcodeNumbers.substring(34);
        var field4 = barcodeNumbers.substring(4, 5);
        var field5 = barcodeNumbers.substring(5, 19);
        var fieldsList = [field1, field2, field3];
        String completeBarcode = field4 + field5;
        for (var field in fieldsList.reversed) {
          var listaNumeros = field.split("").reversed;
          var soma = 0;
          for (var i = 0; i < listaNumeros.length; i++) {
            if (i % 2 == 0) {
              var numero = int.parse(listaNumeros.elementAt(i)) * 2;
              if (numero.toString().length > 1) {
                soma += int.parse(numero.toString()[0]) +
                    int.parse(numero.toString()[1]);
              } else {
                soma += int.parse(listaNumeros.elementAt(i)) * 2;
              }
            } else {
              soma += int.parse(listaNumeros.elementAt(i));
            }
          }
          if (soma % 10 == 0) {
            //DV é 0
            completeBarcode = field + "0" + completeBarcode;
          } else {
            // DV é 10 - (soma%10)
            completeBarcode = field + "${10 - (soma % 10)}" + completeBarcode;
          }
        }
        return completeBarcode;
      }
    }
    return barcodeNumbers;
  }
  //----------------------------------------------------------------------------------------------------

  //----------------OBTENDO VENCIMENTO DO BOLETO----------------
  getDueDateFromBarcode(String barcodeNumbers) {
    if (barcodeNumbers[0] != "8") {
      if (barcodeNumbers.length == 44) {
        final DateTime dateRef = DateTime.parse("1997-10-07");
        final days = int.parse(barcodeNumbers.substring(5, 9));
        var dueDate = dateRef.add(Duration(days: (days + 1)));
        return "${dueDate.day.toString().length == 1 ? '0${dueDate.day}' : dueDate.day}${dueDate.month.toString().length == 1 ? '0${dueDate.month}' : dueDate.month}${dueDate.year}";
      } else if (barcodeNumbers.length == 47) {
        final DateTime dateRef = DateTime.parse("1997-10-07");
        final days = int.parse(barcodeNumbers.substring(33, 37));
        var dueDate = dateRef.add(Duration(days: (days + 1)));
        return "${dueDate.day.toString().length == 1 ? '0${dueDate.day}' : dueDate.day}${dueDate.month.toString().length == 1 ? '0${dueDate.month}' : dueDate.month}${dueDate.year}";
      }
    }
    return "";
  }
  //------------------------------------------------------------

  //----------------OBTENDO VALOR DO BOLETO----------------
  getValueFromBarcode(String barcodeNumbers) {
    String value;
    if (barcodeNumbers.length == 44) {
      if (barcodeNumbers[0] != "8") {
        final fieldValue = barcodeNumbers.substring(9, 19);
        for (var i = 0; i < fieldValue.length; i++) {
          if (fieldValue[i] != "0") {
            var beforeComma = fieldValue.substring(0, fieldValue.length - 2);
            var afterComma = fieldValue.substring(fieldValue.length - 2);

            value = beforeComma + "." + afterComma;
            return value;
          }
        }
      } else {
        final fieldValue = barcodeNumbers.substring(4, 15);
        for (var i = 0; i < fieldValue.length; i++) {
          if (fieldValue[i] != "0") {
            value = fieldValue.substring(i);
            var beforeComma = fieldValue.substring(0, fieldValue.length - 2);
            var afterComma = fieldValue.substring(fieldValue.length - 2);
            value = beforeComma + "." + afterComma;
            return value;
          }
        }
      }
    } else if (barcodeNumbers.length == 47) {
      final fieldValue = barcodeNumbers.substring(37);
      for (var i = 0; i < fieldValue.length; i++) {
        if (fieldValue[i] != "0") {
          value = fieldValue.substring(i);
          var beforeComma = fieldValue.substring(0, fieldValue.length - 2);
          var afterComma = fieldValue.substring(fieldValue.length - 2);
          value = beforeComma + "." + afterComma;
          return value;
        }
      }
    } else if (barcodeNumbers.length == 48) {
      final fieldValue_1 = barcodeNumbers.substring(4, 11);
      final fieldValue_2 = barcodeNumbers.substring(12, 16);
      final fieldValue = fieldValue_1 + fieldValue_2;
      for (var i = 0; i < fieldValue.length; i++) {
        if (fieldValue[i] != "0") {
          value = fieldValue.substring(i);
          var beforeComma = fieldValue.substring(0, fieldValue.length - 2);
          var afterComma = fieldValue.substring(fieldValue.length - 2);
          value = beforeComma + "." + afterComma;
          return value;
        }
      }
    }
    return "";
  }
  //-------------------------------------------------------

  barcodeValidator<bool>(String? code) {
    if (code != null) {
      if (code.length == 44) {
        if (code[0] == "8") {
          var field1 = code.substring(0, 3);
          var field2 = code.substring(4);
          final int dv = int.parse(code.substring(3, 4));
          return validationModel10([field1, field2], dv);
        } else {
          var field1 = code.substring(0, 4);
          var field2 = code.substring(5);
          int dv = int.parse(code.substring(4, 5));
          return validationModel11([field1, field2], dv);
        }
      } else if (code.length == 48) {
        var field1 = code.substring(0, 3);
        var field2 = code.substring(4, 11) +
            code.substring(12, 23) +
            code.substring(24, 35) +
            code.substring(36, 47);
        final int dv = int.parse(code.substring(3, 4));
        return validationModel10([field1, field2], dv);
      } else if (code.length == 47) {
        var field1 = code.substring(0, 4);
        var field2 = code.substring(33) +
            code.substring(4, 9) +
            code.substring(10, 20) +
            code.substring(21, 31);
        final int dv = int.parse(code.substring(32, 33));
        return validationModel11([field1, field2], dv);
      }
    }
    return false;
  }

  validationModel10<bool>(List fieldsList, int dv) {
    var soma = 0;
    int validator;
    for (var field in fieldsList.reversed) {
      var listaNumeros = field.split("").reversed;
      for (var i = 0; i < listaNumeros.length; i++) {
        if (i % 2 == 0) {
          var numero = int.parse(listaNumeros.elementAt(i)) * 2;
          if (numero.toString().length > 1) {
            soma += int.parse(numero.toString()[0]) +
                int.parse(numero.toString()[1]);
          } else {
            soma += int.parse(listaNumeros.elementAt(i)) * 2;
          }
        } else {
          soma += int.parse(listaNumeros.elementAt(i));
        }
      }
    }
    if (soma % 10 == 0) {
      //DV é 0
      validator = 0;
    } else {
      // DV é 10 - (soma%10)
      validator = 10 - (soma % 10);
    }
    return dv == validator;
  }

  validationModel11<bool>(List fieldsList, int dv) {
    int validator;
    int counter = 2;
    var soma = 0;
    for (var field in fieldsList.reversed) {
      var listaNumeros = field.split("").reversed;
      for (var i = 0; i < listaNumeros.length; i++) {
        soma += int.parse(listaNumeros.elementAt(i)) * counter;
        if (counter == 9) {
          counter = 2;
        } else {
          counter++;
        }
      }
    }
    if (11 - (soma % 11) == 0 ||
        11 - (soma % 11) == 10 ||
        11 - (soma % 11) == 11) {
      validator = 1;
    } else {
      validator = 11 - (soma % 11);
    }
    return dv == validator;
  }
}
