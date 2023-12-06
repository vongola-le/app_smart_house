import 'package:app_smart_house/model/DeviceData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DatabaseServiceDevice {
  static Future<List<Device>> getDevices() async {
    DataSnapshot snapshot =
        await FirebaseDatabase.instance.ref().child("Device").get();

    List<Device> devices = [];

    List<dynamic> values = snapshot.value as List<dynamic>;

    for (var vl in values) {
      devices.add(Device.fromSnapShot(vl as Map<Object?, Object?>));
    }

    return devices;
  }

  static Future<void> updateData(Device device) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('Device/${device.id - 1}').update({
      "id": device.id,
      "name": device.name,
      "effect": device.effect,
      "room": device.room,
      "status": device.status,
      "type": device.type,
      "mode": device.mode,
      "data": device.data,
      "id_room": device.id_room
    });
  }

  static Future<void> addData(Device device) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('Device/${device.id - 1}').set({
      "id": device.id,
      "name": device.name,
      "effect": device.effect,
      "room": device.room,
      "status": device.status,
      "type": device.type,
      "mode": device.mode,
      "data": device.data,
      "id_room": device.id_room
    });
  }

  static Future<void> delData(Device device) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('Device/${device.id - 1}').remove();
  }
}
