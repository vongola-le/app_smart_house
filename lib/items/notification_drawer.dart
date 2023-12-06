import 'package:app_smart_house/model/DataServiceNotification.dart';
import 'package:app_smart_house/model/NotificationData.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class NotificationDrawer extends StatefulWidget {
  const NotificationDrawer({super.key});

  @override
  State<NotificationDrawer> createState() => _NotificationDrawerState();
}

class _NotificationDrawerState extends State<NotificationDrawer> {
  List<NotificationClass> lst_noti = [];
  _setupNotiData() async {
    List<NotificationClass> data =
        await DatabaseServiceNotification.getNotification();
    data.sort(
      (a, b) => b.time.compareTo(a.time),
    );
    if (mounted) {
      setState(() {
        lst_noti = data;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupNotiData();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 10), () {
      _setupNotiData();
    });
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 80,
            child: DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Thông Báo",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  IconButton(
                    onPressed: () {
                      Scaffold.of(context).closeEndDrawer();
                    },
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    iconSize: 28,
                  )
                ],
              ),
              decoration: BoxDecoration(color: const Color(0xFF0597F2)),
            ),
          ),
          for (var value in lst_noti)
            Column(
              children: [NotificationItem(notifi: value)],
            )
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  NotificationItem({super.key, required this.notifi});
  NotificationClass notifi =
      NotificationClass(id: 0, detail: "", time: DateTime.now(), title: "");

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 215, 230, 236)),
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          child: Text(
                            notifi.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Text(
                          DateFormat.yMMMd().format(
                            notifi.time,
                          ),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    Text(
                      notifi.detail,
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ))));
  }
}
