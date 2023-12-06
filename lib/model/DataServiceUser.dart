import 'package:app_smart_house/model/UserData.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseServiceUser {
  static Future<List<User2>> getUsers() async {
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .ref()
        .child("Users")
        .get(); // to debug and see if data is returned

    List<User2> users = [];
    List<dynamic> values = snapshot.value as List<dynamic>;
    User2 user;
    for (var vl in values) {
      users.add(User2.fromSnapShot(vl as Map<Object?, Object?>));
    }
    return users;
  }

  static Future<User2> getUser(String email) async {
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .ref()
        .child("Users/$email")
        .get(); // to debug and see if data is returned
    User2 user;
    dynamic values = snapshot.value as dynamic;

    user = User2.fromSnapShot(values as Map<Object?, Object?>);
    return user;
  }

  static Future<void> updateData(User2 user) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('Users/${user.id - 1}').update({
      "id": user.id,
      "img": user.img,
      "name": user.name,
      "account": user.account,
      "date": user.date,
      "password": user.password,
      "phone": user.phone,
      "email": user.email,
      "address": user.address,
      "sex": user.sex,
    });
  }

  static Future<void> addData(User2 user) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('Users/${user.id - 1}').set({
      "id": user.id,
      "img": user.img,
      "name": user.name,
      "account": user.account,
      "date": user.date,
      "password": user.password,
      "phone": user.phone,
      "email": user.email,
      "address": user.address,
      "sex": user.sex,
    });
  }
}
