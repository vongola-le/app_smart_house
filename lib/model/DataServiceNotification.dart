import 'package:app_smart_house/model/NotificationData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DatabaseServiceNotification {
  static Future<List<NotificationClass>> getNotification() async {
    DataSnapshot snapshot =
        await FirebaseDatabase.instance.ref().child("Notification").get();

    List<NotificationClass> notifications = [];

    List<dynamic> values = snapshot.value as List<dynamic>;

    for (var vl in values) {
      notifications
          .add(NotificationClass.fromSnapShot(vl as Map<Object?, Object?>));
    }

    return notifications;
  }
}
