import 'package:flutter/services.dart';

class InforUserReader {
  Future<String> getInfor() async {
    String s = "";
    try {
      s = await rootBundle.loadString('assets/data/user.json');
      return (s);
    } catch (e) {
      return e.toString();
    }
  }
}
