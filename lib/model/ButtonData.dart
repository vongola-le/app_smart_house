class Button{
  String name;
  String room;
  String function;

  Button({required this.name,required this.room,required this.function});

  Button.fromSnapShot(Map<Object?, Object?> js)
      : name = js["name"].toString(),
        room = js["room"].toString(),
        function=js["function"].toString();

  toJson() {
    return {
      "name": name,
      "room": room,
      "function":function
    };
  }
}