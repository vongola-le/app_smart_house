import 'package:firebase_database/firebase_database.dart';

class User2 {
  int id;
  String img;
  String name;
  String account;
  String date;
  String password;
  String phone;
  String email;
  String address;
  String sex;

  User2(
      {required this.id,
      required this.img,
      required this.name,
      required this.account,
      required this.date,
      required this.password,
      required this.phone,
      required this.email,
      required this.address,
      required this.sex});

  User2.fromSnapShot(Map<Object?, Object?> js)
      : id = int.parse(js["id"].toString()),
        img = js["img"].toString(),
        name = js["name"].toString(),
        account = js["account"].toString(),
        date = js["date"].toString(),
        password = js["password"].toString(),
        phone = js["phone"].toString(),
        email = js["email"].toString(),
        address = js["address"].toString(),
        sex = js["sex"].toString();

  toJson() {
    return {
      "id": id,
      "img": img,
      "name": name,
      "account": account,
      "date": date,
      "password": password,
      "phone": phone,
      "email": email,
      "address": address,
      "sex": sex,
    };
  }
}
