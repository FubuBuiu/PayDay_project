import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nlw_project/models/boleto_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class MyNotification {
  static final notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            'channel id', 'channel name', 'channel description',
            importance: Importance.max, priority: Priority.high),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android);
    tz.initializeTimeZones();

    final details = await notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }
    await notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  //-----------APENAS MOSTRAR UMA NOTIFICAÇÃO-----------
  // static Future showNotification({
  //   int id = 0,
  //   String? title,
  //   String? body,
  //   String? payload,
  // }) async =>
  //     notifications.show(id, title, body, await notificationDetails(),
  //         payload: payload);
  //----------------------------------------------------

  //-----------NOTIFICAÇÃO PROGRAMADA-----------
  static Future scheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
  //--------------------------------------------

  //-----------CANCELAR NOTIFICAÇÃO-----------
  static void cancel(int id) => notifications.cancel(id);
  //------------------------------------------

  int idNotification(String barcode, int day, int multiplier) {
    var soma = 0;

    var listaNumeros = barcode.split("").reversed;
    for (var i = 0; i < listaNumeros.length; i++) {
      if (i % 2 == 0) {
        var numero = int.parse(listaNumeros.elementAt(i)) * 2;
        if (numero.toString().length > 1) {
          soma +=
              int.parse(numero.toString()[0]) + int.parse(numero.toString()[1]);
        } else {
          soma += int.parse(listaNumeros.elementAt(i)) * 2;
        }
      } else {
        soma += int.parse(listaNumeros.elementAt(i));
      }
    }
    return (soma + day) * multiplier;
  }

  void createNotification(BoletoModel boleto) {
    var day = boleto.dueDate!.substring(0, 2);
    var month = boleto.dueDate!.substring(3, 5);
    var year = boleto.dueDate!.substring(6);
    var dueDate = DateTime.parse(year + month + day);
    var today = DateTime.parse(
        "${DateTime.now().year}${DateTime.now().month.toString().length == 1 ? '0${DateTime.now().month}' : DateTime.now().month}${DateTime.now().day.toString().length == 1 ? '0${DateTime.now().day}' : DateTime.now().day}");

    final String notificationInDueDate08 =
        "${dueDate.year}${dueDate.month.toString().length == 1 ? '0${dueDate.month}' : dueDate.month}${dueDate.day.toString().length == 1 ? '0${dueDate.day}' : dueDate.day}T021600";
    final String notificationInDueDate16 =
        "${dueDate.year}${dueDate.month.toString().length == 1 ? '0${dueDate.month}' : dueDate.month}${dueDate.day.toString().length == 1 ? '0${dueDate.day}' : dueDate.day}T021700";
    final String notificationOneDayEarlier08 =
        "${dueDate.year}${dueDate.month.toString().length == 1 ? '0${dueDate.month}' : dueDate.month}${dueDate.day.toString().length == 1 ? '0${dueDate.day - 1}' : dueDate.day - 1}T080000";
    final String notificationOneDayEarlier16 =
        "${dueDate.year}${dueDate.month.toString().length == 1 ? '0${dueDate.month}' : dueDate.month}${dueDate.day.toString().length == 1 ? '0${dueDate.day - 1}' : dueDate.day - 1}T160000";

    if (dueDate.difference(today).inDays == 0) {
      //ENTRA AQUI SE O DIA QUE ELE CADASTROU FOR O DIA DE VENCIMENTO
      print("NOT HOJE");
      if (today.hour < 8) {
        //CADASTROU ANTES DAS 8 HORAS
        //Notificação das 8 horas
        MyNotification.scheduledNotification(
            id: MyNotification()
                .idNotification(boleto.barcode!, dueDate.day, 8),
            title: "ATENÇÃO!!!!!",
            body: "O boleto ${boleto.name} vence hoje",
            payload: "payload",
            scheduledDate: DateTime.parse(notificationInDueDate08));
        //Notificação das 16 horas
        MyNotification.scheduledNotification(
            id: MyNotification()
                .idNotification(boleto.barcode!, dueDate.day, 16),
            title: "ATENÇÃO!!!!!",
            body: "O boleto ${boleto.name} vence hoje",
            payload: "payload",
            scheduledDate: DateTime.parse(notificationInDueDate16));
      } else if (today.hour < 16) {
        //CADASTROU ANTES DAS 16 HORAS
        MyNotification.scheduledNotification(
            id: MyNotification()
                .idNotification(boleto.barcode!, dueDate.day, 16),
            title: "ATENÇÃO!!!!!",
            body: "O boleto ${boleto.name} vence hoje",
            payload: "payload",
            scheduledDate: DateTime.parse(notificationInDueDate16));
      }
    } else if (dueDate.difference(today).inDays == 1) {
      print("NOT UM DIA ANTES");
      //ENTRA AQUI SE O DIA QUE ELE CADASTROU FOR VESPERA DO VENCIMENTO
      //SE CADASTROU ANTES DAS 8 HORAS
      if (today.hour < 8) {
        //Notificação das 8 horas
        MyNotification.scheduledNotification(
            id: MyNotification()
                .idNotification(boleto.barcode!, dueDate.day - 1, 8),
            title: "ATENÇÃO!!!!!",
            body: "O boleto ${boleto.name} vence amanhã",
            payload: "payload",
            scheduledDate: DateTime.parse(notificationOneDayEarlier08));
        //Notificação das 16 horas
        MyNotification.scheduledNotification(
            id: MyNotification()
                .idNotification(boleto.barcode!, dueDate.day - 1, 16),
            title: "ATENÇÃO!!!!!",
            body: "O boleto ${boleto.name} vence amanhã",
            payload: "payload",
            scheduledDate: DateTime.parse(notificationOneDayEarlier08));
      } else if (today.hour < 16) {
        //SE CRIOU ANTES DAS 16 HORAS
        //Notificação das 16 horas
        MyNotification.scheduledNotification(
            id: MyNotification()
                .idNotification(boleto.barcode!, dueDate.day - 1, 16),
            title: "ATENÇÃO!!!!!",
            body: "O boleto ${boleto.name} vence amanhã",
            payload: "payload",
            scheduledDate: DateTime.parse(notificationOneDayEarlier16));
      }
      MyNotification.scheduledNotification(
          id: MyNotification().idNotification(boleto.barcode!, dueDate.day, 8),
          title: "ATENÇÃO!!!!!",
          body: "O boleto ${boleto.name} vence hoje",
          payload: "payload",
          scheduledDate: DateTime.parse(notificationInDueDate08));
      MyNotification.scheduledNotification(
          id: MyNotification().idNotification(boleto.barcode!, dueDate.day, 16),
          title: "ATENÇÃO!!!!!",
          body: "O boleto ${boleto.name} vence hoje",
          payload: "payload",
          scheduledDate: DateTime.parse(notificationInDueDate16));
    } else {
      print("NOT DIA LONGE");
      //SE CADASTROU EM UMA DATA DISTATE DO VENCIMENTO
      //------------NOTIFICAÇÕES UM DIA ANTES DO VENCIMENTO------------
      MyNotification.scheduledNotification(
          id: MyNotification()
              .idNotification(boleto.barcode!, dueDate.day - 1, 8),
          title: "Atenção!!!!!",
          body: "O boleto ${boleto.name} vence amanhã",
          payload: "payload",
          scheduledDate: DateTime.parse(notificationOneDayEarlier08));
      MyNotification.scheduledNotification(
          id: MyNotification()
              .idNotification(boleto.barcode!, dueDate.day - 1, 16),
          title: "Atenção!!!!!",
          body: "O boleto ${boleto.name} vence amanhã",
          payload: "payload",
          scheduledDate: DateTime.parse(notificationOneDayEarlier16));
      //--------------------------------------------------------------

      //------------------NOTIFICAÇÕES NO DIA DO VENCIMENTO------------------
      MyNotification.scheduledNotification(
          id: MyNotification().idNotification(boleto.barcode!, dueDate.day, 8),
          title: "Atenção!!!!!",
          body: "O boleto ${boleto.name} vence hoje",
          payload: "payload",
          scheduledDate: DateTime.parse(notificationInDueDate08));
      MyNotification.scheduledNotification(
          id: MyNotification().idNotification(boleto.barcode!, dueDate.day, 16),
          title: "Atenção!!!!!",
          body: "O boleto ${boleto.name} vence hoje",
          payload: "payload",
          scheduledDate: DateTime.parse(notificationInDueDate16));
      //--------------------------------------------------------------------
    }
  }
}
