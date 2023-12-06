class Device {
  int id;
  int effect;
  String name;
  String room;
  int status;
  int type;
  int mode;
  int id_room;
  String data;

  Device(
      {required this.id,
      required this.name,
      required this.effect,
      required this.room,
      required this.status,
      required this.type,
      required this.mode,
      required this.data,
      required this.id_room});

  Device.fromSnapShot(Map<Object?, Object?> js)
      : id = int.parse(js["id"].toString()),
        name = js["name"].toString(),
        effect = int.parse(js["effect"].toString()),
        room = js["room"].toString(),
        status = int.parse(js["status"].toString()),
        type = int.parse(js["type"].toString()),
        mode = int.parse(js["mode"].toString()),
        data = js["data"].toString(),
        id_room = int.parse(js["id_room"].toString());

  toJson() {
    return {
      "id": id,
      "name": name,
      "effect": effect,
      "room": room,
      "status": status,
      "type": type,
      "mode": mode,
      "data": data,
      "id_room": id_room
    };
  }
}
