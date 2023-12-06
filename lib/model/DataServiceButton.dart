import 'package:app_smart_house/model/ButtonData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DatabaseServiceButton {
  static Future<List<Button>> getDevices() async {
    DataSnapshot snapshot =
        await FirebaseDatabase.instance.ref().child("Buttons").get();

    List<Button> buttons = [];

    List<dynamic> values = snapshot.value as List<dynamic>;

    for (var vl in values) {
      buttons.add(Button.fromSnapShot(vl as Map<Object?, Object?>));
    }
    return buttons;
  }
}
