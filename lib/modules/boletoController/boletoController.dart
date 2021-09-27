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

    MyNotification().createNotification(boleto);
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
      MyNotification.cancel(MyNotification().idNotification(
          boleto.barcode!, int.parse(boleto.dueDate!.substring(0, 2)), 8));
      MyNotification.cancel(MyNotification().idNotification(
          boleto.barcode!, int.parse(boleto.dueDate!.substring(0, 2)), 16));
      MyNotification.cancel(MyNotification().idNotification(
          boleto.barcode!, int.parse(boleto.dueDate!.substring(0, 2)) - 1, 8));
      MyNotification.cancel(MyNotification().idNotification(
          boleto.barcode!, int.parse(boleto.dueDate!.substring(0, 2)) - 1, 16));
    }
  }

  Future getBoletos(local) async {
    List<BoletoModel> boletos = [];
    final authController = AuthControlller();
    final user = await authController.getUser();
    FirebaseFirestore db = await DBFirestore.get();
    try {
      var userBoletos =
          await db.collection('users').doc(user.id).collection(local).get();

      userBoletos.docs.forEach((doc) {
        final data = doc.data();
        boletos.add(
          BoletoModel(
            dueDate: data['vencimento'],
            barcode: data['codigo'],
            name: data['nome'],
            value: data['valor'].toDouble(),
          ),
        );
      });
      return boletos;
    } catch (e) {
      return boletos;
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
