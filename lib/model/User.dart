import 'dart:convert';
import 'package:app_smart_house/model/Db_User_Reader.dart';

class Users {
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
  Users(this.id, this.img, this.name, this.account, this.date, this.password,
      this.phone, this.email, this.address, this.sex);

  Users.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        img = json['img'],
        name = json['name'],
        account = json['account'],
        date = json['date'],
        password = json['password'],
        phone = json['phone'],
        email = json['email'],
        address = json['address'],
        sex = json['sex'];
  static List<Users> users = [];

  static Future<void> loadData() async {
    InforUserReader reader = InforUserReader();
    String data = await reader.getInfor();
    List<dynamic> lst = jsonDecode(data);
    for (var entry in lst) {
      users.add(Users.fromJson(entry));
    }
  }
}
