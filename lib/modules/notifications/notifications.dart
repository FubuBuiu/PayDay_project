import 'package:flutter/material.dart';
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
          'channel id',
          'channel name',
          'channel description',
          importance: Importance.max,
          priority: Priority.high,
          color: Color(0xFFFFA500)
        ),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@drawable/notification_icon');
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

  void cancelBillNotifications(BoletoModel boleto) {
    final day = boleto.dueDate!.substring(0, 2);
    final month = boleto.dueDate!.substring(3, 5);
    final year = boleto.dueDate!.substring(6);
    final dueDate = DateTime.parse(year + month + day);
    final oneDaysEarlierDate = dueDate.subtract(const Duration(days: 1));
    final threeDaysEarlierDate = dueDate.subtract(const Duration(days: 3));

    notifications
        .cancel(idNotification(boleto.barcode!, threeDaysEarlierDate.day, 15));
    notifications
        .cancel(idNotification(boleto.barcode!, oneDaysEarlierDate.day, 8));
    notifications
        .cancel(idNotification(boleto.barcode!, oneDaysEarlierDate.day, 15));
    notifications.cancel(idNotification(boleto.barcode!, dueDate.day, 8));
    notifications.cancel(idNotification(boleto.barcode!, dueDate.day, 15));
  }

  void createBillNotifications(BoletoModel boleto) async {
    final day = boleto.dueDate!.substring(0, 2);
    final month = boleto.dueDate!.substring(3, 5);
    final year = boleto.dueDate!.substring(6);
    final dueDate = DateTime.parse(year + month + day);
    final oneDaysEarlierDate = dueDate.subtract(const Duration(days: 1));
    final threeDaysEarlierDate = dueDate.subtract(const Duration(days: 3));
    final today = DateTime.parse(
        "${DateTime.now().year}${DateTime.now().month.toString().length == 1 ? '0${DateTime.now().month}' : DateTime.now().month}${DateTime.now().day.toString().length == 1 ? '0${DateTime.now().day}' : DateTime.now().day}");

    void notificationInDueDate() {
      MyNotification.scheduledNotification(
        id: MyNotification().idNotification(boleto.barcode!, dueDate.day, 8),
        title: "ATENÇÃO!!!!!",
        body: "O boleto ${boleto.name} vence hoje",
        payload: "payload",
        scheduledDate: DateTime.parse(
            "${dueDate.year}${dueDate.month.toString().length == 1 ? '0${dueDate.month}' : dueDate.month}${dueDate.day.toString().length == 1 ? '0${dueDate.day}' : dueDate.day}T080000"),
      );
      MyNotification.scheduledNotification(
        id: MyNotification().idNotification(boleto.barcode!, dueDate.day, 15),
        title: "ATENÇÃO!!!!!",
        body: "O boleto ${boleto.name} vence hoje",
        payload: "payload",
        scheduledDate: DateTime.parse(
            "${dueDate.year}${dueDate.month.toString().length == 1 ? '0${dueDate.month}' : dueDate.month}${dueDate.day.toString().length == 1 ? '0${dueDate.day}' : dueDate.day}T150000"),
      );
    }

    void notificationOneDayEarlier() {
      MyNotification.scheduledNotification(
        id: MyNotification()
            .idNotification(boleto.barcode!, oneDaysEarlierDate.day, 8),
        title: "ATENÇÃO!!!!!",
        body: "O boleto ${boleto.name} vence amanhã",
        payload: "payload",
        scheduledDate: DateTime.parse(
            "${oneDaysEarlierDate.year}${oneDaysEarlierDate.month.toString().length == 1 ? '0${oneDaysEarlierDate.month}' : oneDaysEarlierDate.month}${oneDaysEarlierDate.day.toString().length == 1 ? '0${oneDaysEarlierDate.day}' : oneDaysEarlierDate.day}T080000"),
      );
      MyNotification.scheduledNotification(
        id: MyNotification()
            .idNotification(boleto.barcode!, oneDaysEarlierDate.day, 15),
        title: "ATENÇÃO!!!!!",
        body: "O boleto ${boleto.name} vence amanhã",
        payload: "payload",
        scheduledDate: DateTime.parse(
            "${oneDaysEarlierDate.year}${oneDaysEarlierDate.month.toString().length == 1 ? '0${oneDaysEarlierDate.month}' : oneDaysEarlierDate.month}${oneDaysEarlierDate.day.toString().length == 1 ? '0${oneDaysEarlierDate.day}' : oneDaysEarlierDate.day}T150000"),
      );
    }

    void notificationThreeDaysEarlier() {
      MyNotification.scheduledNotification(
        id: MyNotification()
            .idNotification(boleto.barcode!, threeDaysEarlierDate.day, 15),
        title: "ATENÇÃO!!!!!",
        body: "O boleto ${boleto.name} vence em 3 dias",
        payload: "payload",
        scheduledDate: DateTime.parse(
            "${threeDaysEarlierDate.year}${threeDaysEarlierDate.month.toString().length == 1 ? '0${threeDaysEarlierDate.month}' : threeDaysEarlierDate.month}${threeDaysEarlierDate.day.toString().length == 1 ? '0${threeDaysEarlierDate.day}' : threeDaysEarlierDate.day}T150000"),
      );
    }

    if (!dueDate.difference(today).inDays.isNegative) {
      if (today.isBefore(threeDaysEarlierDate)) {
        notificationThreeDaysEarlier();
        notificationOneDayEarlier();
        notificationInDueDate();
      } else if (today.isBefore(oneDaysEarlierDate)) {
        notificationOneDayEarlier();
        notificationInDueDate();
      } else if (today.isBefore(dueDate)) {
        notificationInDueDate();
      }
    }
  }
}
