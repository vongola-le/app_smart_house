import 'package:app_smart_house/items/room_detail.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoomItem extends StatelessWidget {
  const RoomItem(
      {super.key,
      required this.name,
      this.sl = 0,
      this.tem = "",
      required this.img,
      required this.id_room});
  final name;
  final tem;
  final img;
  final int sl;
  final id_room;
  @override
  Widget build(BuildContext context) {
    String tb1 = "Không có thiết bị";
    String tb2 = "Có $sl thiết bị";

    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color.fromARGB(255, 215, 230, 236)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Column(
            children: [
              Container(
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage(
                      img,
                    ),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(tem == "" ? tem : tem + "°C"),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          sl != 0 ? tb2 : tb1,
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetail(
                name: name, sl: sl, tem: tem, img: img, id_room: id_room),
          ),
        );
      },
    );
  }
}
