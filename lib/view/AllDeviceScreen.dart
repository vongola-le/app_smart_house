import 'package:app_smart_house/items/add_device.dart';
import 'package:app_smart_house/items/device_item.dart';
import 'package:app_smart_house/model/DataServiceButton.dart';
import 'package:app_smart_house/model/DataServiceDevice.dart';
import 'package:app_smart_house/model/ButtonData.dart';
import 'package:app_smart_house/model/DeviceData.dart';
import 'package:flutter/material.dart';

class AllDevices extends StatefulWidget {
  const AllDevices({super.key});

  @override
  State<AllDevices> createState() => _AllDevicesState();
}

class _AllDevicesState extends State<AllDevices> {
  List<Device> lst_devices = [];
  List<Button> lst_buttons = [];
  int newIdDevice = 1;

  _setupDevice() async {
    List<Device> deviceData = await DatabaseServiceDevice.getDevices();
    if (mounted) {
      setState(() {
        newIdDevice = deviceData[deviceData.length - 1].id + 1;
        lst_devices = deviceData;
      });
    }
  }

  _setupButton() async {
    List<Button> buttonData = await DatabaseServiceButton.getDevices();
    if (mounted) {
      setState(() {
        lst_buttons = buttonData;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupDevice();
    _setupButton();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      _setupDevice();
    });
    return Scaffold(
        appBar: AppBar(
          title: Text("Trang Thiết Bị"),
          backgroundColor: const Color(0xFF0597F2),
          actions: [
            IconButton(
              tooltip: "Hướng dẫn sử dụng",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Hướng dẫn thao tác!'),
                      content: Text(
                          '- Nhấn giữ vào thiết bị để mở hộp thoại xóa thiết bị.\n- Nhấn 2 lần vào thiết bị để mở hộp thoại thực hiện đổi tên và vị trí của thiết bị'),
                      actions: [
                        TextButton(
                          child: Text(
                            'Ok',
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.help_outline_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
          children: [
            if (lst_devices.isEmpty)
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Icon(
                    Icons.disabled_by_default_outlined,
                    color: Colors.red[100],
                    size: 100,
                  ),
                  Text(
                    'No device',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 10),
                  Text('Click add new device to add device',
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => add_device(
                                      newIdDevice: newIdDevice,
                                    )));
                      },
                      child:
                          Text("Add device", style: TextStyle(fontSize: 30))),
                ],
              )
            else
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All device',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => add_device(
                                          newIdDevice: newIdDevice,
                                        )));
                          },
                          child: Text("Add device")),
                    ],
                  ),
                  for (var value in lst_devices)
                    Column(
                      children: [
                        DeviceItem(
                          device: value,
                        )
                      ],
                    )
                ],
              ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Text(
              'All Button',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Text(
              'Số lượng: 7',
              style: TextStyle(fontSize: 18),
            ),
            Column(
              children: [
                for (var value in lst_buttons)
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      InforButton(
                        function: value.function,
                        location: value.room,
                        name: value.name,
                        width: false,
                      )
                    ],
                  )
              ],
            )
          ],
        ));
  }
}

class InforButton extends StatelessWidget {
  InforButton(
      {super.key,
      required this.function,
      required this.location,
      required this.name,
      this.width = true});
  String name;
  String location;
  String function;
  bool width;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0),
        child: Container(
            width: width
                ? MediaQuery.of(context).size.width / 2 - 10
                : MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 215, 230, 236)),
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.radio_button_on_outlined, size: 50),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Container(
                              width: width
                                  ? MediaQuery.of(context).size.width / 2 - 80
                                  : MediaQuery.of(context).size.width - 80,
                              height: MediaQuery.of(context).size.height / 8,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      location,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blueGrey),
                                    ),
                                    Text(
                                      "Chức năng: $function",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ]))));
  }
}
