import 'package:app_smart_house/items/add_device.dart';
import 'package:app_smart_house/items/device_item.dart';
import 'package:app_smart_house/model/DataServiceDevice.dart';
import 'package:app_smart_house/model/DeviceData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RoomDetail extends StatefulWidget {
  const RoomDetail(
      {super.key,
      required this.name,
      this.tem = "",
      this.sl = 0,
      required this.img,
      required this.id_room});
  final id_room;
  final name;
  final tem;
  final img;
  final int sl;

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  List<Device> lst_devices = [];
  int newIdDevice = 0;

  _setupDevice() async {
    List<Device> devicesdata = await DatabaseServiceDevice.getDevices();
    if (mounted) {
      setState(() {
        lst_devices.clear();
        newIdDevice = devicesdata[devicesdata.length - 1].id + 1;
        for (var value in devicesdata) {
          if (value.id_room == widget.id_room) {
            lst_devices.add(value);
          }
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupDevice();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      _setupDevice();
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFF0597F2),
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => add_device(
                            newIdDevice: newIdDevice,
                          )));
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            tooltip: "Thêm thiết bị",
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: ClipRRect(
                child: Image(
                  image: AssetImage(widget.img),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 2, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Số thiết bị: ${widget.sl}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    widget.tem == "" ? widget.tem : "Nhiệt độ: ${widget.tem}°C",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thiết bị:",
                    style: TextStyle(fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        for (var value in lst_devices) {
                          value.status = 1;
                          DatabaseServiceDevice.updateData(value);
                        }
                      });
                    },
                    child: Text(
                      "Mở tất cả",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 106, 189, 228)),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  if (lst_devices.isNotEmpty)
                    Column(
                      children: List.generate(
                        lst_devices.length,
                        (index) => DeviceItem(device: lst_devices[index]),
                      ),
                    )
                  else
                    const Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text(
                          "Không có thiết bị đang hoạt động !",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
