import 'package:nlw_project/auth/auth.controller.dart';
import 'package:nlw_project/data/db_firestore.dart';
import 'package:nlw_project/models/boleto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nlw_project/modules/notifications/notifications.dart';

class BoletoController {
  Future<void> addBoleto(BoletoModel boleto) async {
    FirebaseFirestore db = await DBFirestore.get();
    final authController = AuthControlller();
    final user = await authController.getUser();
    await db
        .collection("users")
        .doc(user.id)
        .collection("bank_statement")
        .doc(boleto.barcode)
        .set(
      {
        "codigo": boleto.barcode,
        "nome": boleto.name,
        "valor": boleto.value,
        "vencimento": boleto.dueDate
      },
    );

    MyNotification().createBillNotifications(boleto);
  }

  Future<void> boletoPaid(BoletoModel boleto) async {
    final authController = AuthControlller();
    final user = await authController.getUser();
    FirebaseFirestore db = await DBFirestore.get();
    // -----------CRIANDO BOLETO NA COLEÇÃO extract-----------
    await db
        .collection("users")
        .doc(user.id)
        .collection("extract")
        .doc(boleto.barcode)
        .set(
      {
        "codigo": boleto.barcode,
        "nome": boleto.name,
        "valor": boleto.value,
        "vencimento": boleto.dueDate
      },
    );
    // -------------------------------------------------------

    // -----------DELETANDO BOLETO DA COLEÇÃO bank_statement-----------
    await deleteBoleto("bank_statement", boleto);
    //-----------------------------------------------------------------
  }

  Future<void> deleteBoleto(String boletoType, BoletoModel boleto) async {
    final authController = AuthControlller();
    final user = await authController.getUser();
    FirebaseFirestore db = await DBFirestore.get();
    await db.runTransaction(
      (Transaction transaction) async {
        await transaction.delete(
          db
              .collection("users")
              .doc(user.id)
              .collection(boletoType)
              .doc(boleto.barcode),
        );
      },
    );
    if (boletoType == "bank_statement") {
      MyNotification().cancelBillNotifications(boleto);
    }
  }

  Future<void> deleteAllBoletosUser() async {
    FirebaseFirestore db = await DBFirestore.get();
    final authController = AuthControlller();
    final user = await authController.getUser();

    var boletos = await db
        .collection("users")
        .doc(user.id)
        .collection("bank_statement")
        .get();
    for (var boleto in boletos.docs) {
      await boleto.reference.delete();
    }

    var extratos =
        await db.collection("users").doc(user.id).collection("extract").get();
    for (var boleto in extratos.docs) {
      await boleto.reference.delete();
    }

    db.collection("users").doc(user.id).delete();
  }
}
