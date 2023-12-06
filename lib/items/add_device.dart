import 'package:app_smart_house/model/DataServiceDevice.dart';
import 'package:app_smart_house/model/DeviceData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class add_device extends StatefulWidget {
  const add_device({super.key, required this.newIdDevice});
  final newIdDevice;
  @override
  State<add_device> createState() => _add_deviceState();
}

class _add_deviceState extends State<add_device> {
  List<Station> stations = [
    Station(
        Image.asset(
          "assets/img/lamp.jpg",
          width: 125,
          height: 125,
          fit: BoxFit.cover,
        ),
        'Lamp',
        'Loại đèn thông thường, không có chức năng đặc biệt',
        0),
    Station(
        Image.asset(
          "assets/img/lamp2.jpg",
          width: 125,
          height: 125,
          fit: BoxFit.cover,
        ),
        'Adjustable lamp',
        'Loại đèn có chức năng tăng giảm độ sáng',
        1),
    Station(
        Image.asset(
          "assets/img/door.jpg",
          width: 125,
          height: 125,
          fit: BoxFit.cover,
        ),
        'Cửa tự động',
        'Cho phép điều khiển cửa',
        2),
    Station(
        Image.asset(
          "assets/img/lcd.png",
          width: 125,
          height: 125,
          fit: BoxFit.cover,
        ),
        'Màn hình LCD',
        'Hiển thị thông tin và cho phép bật/tắt màn hình',
        3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Device"),
        backgroundColor: const Color(0xFF0597F2),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        color: Color.fromARGB(255, 231, 231, 229),
        child: GridView.count(
          childAspectRatio: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          crossAxisCount: 1,
          children: stations.map((item) {
            return StationItem(
              item: item,
              newIdDevice: widget.newIdDevice,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class StationItem extends StatefulWidget {
  const StationItem(
      {Key? key, required this.item, required this.newIdDevice, this.id_room})
      : super(key: key);
  final Station item;
  final newIdDevice;
  final id_room;

  @override
  State<StationItem> createState() => _StationItemState();
}

class _StationItemState extends State<StationItem> {
  final bool tt = false;
  bool isChecked = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var inkWell = InkWell(
      onTap: () {
        // chuyen trang khi click vao

        print('Clicked ${widget.item.name}');
        openDialog(
          context,
          widget.item.type,
          widget.newIdDevice,
        );
      },
      splashColor: Colors.yellow,

      //child: Card(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 215, 230, 236)),
        alignment: Alignment.topLeft,
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: widget.item.img,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width / 1.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      widget.item.infor,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )),
        ]),
      ),
    );
    //),
    return inkWell;
  }

  Future<void> openDialog(
      BuildContext context, int typyDevice, int newIdDevice) async {
    Device addDevice = Device(
        id: newIdDevice,
        name: "",
        effect: 0,
        room: "",
        status: 0,
        type: typyDevice,
        mode: 0,
        data: "",
        id_room: 0);
    final TextEditingController controller = TextEditingController();
    String dropdownValue = 'Phòng khách';
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              //title: Text('Tên thiết bị'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text(
                      'Tên thiết bị',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    //SizedBox(height: 5),
                    TextField(
                      controller: controller,
                      decoration:
                          InputDecoration(hintText: 'Enter your device name'),
                    ),
                    SizedBox(height: 30.0),
                    const Text(
                      'Chọn Phòng',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    //SizedBox(height: 5),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          if (dropdownValue == 'Phòng khách') {
                            addDevice.id_room = 0;
                          } else if (dropdownValue == 'Garage') {
                            addDevice.id_room = 1;
                          } else if (dropdownValue == 'Phòng ăn') {
                            addDevice.id_room = 2;
                          } else if (dropdownValue == 'Phòng ngủ') {
                            addDevice.id_room = 3;
                          } else if (dropdownValue == 'WC') {
                            addDevice.id_room = 4;
                          }
                          addDevice.room = dropdownValue;
                        });
                      },
                      items: <String>[
                        'Phòng ngủ',
                        'Phòng ăn',
                        'Phòng khách',
                        'WC',
                        'Garage'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    addDevice.room = dropdownValue;
                    addDevice.name = controller.text.toString();
                    DatabaseServiceDevice.addData(
                      addDevice,
                    );
                    Navigator.of(context).pop(controller.text);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Thêm thành công!',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 140, 238, 143))),
                              Icon(
                                Icons.check_circle_outlined,
                                color: const Color.fromARGB(255, 140, 238, 143),
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Ok',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 18)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void add(BuildContext context) {
    Navigator.of(context).pop(controller.text);
  }
}

class Station {
  Image img;
  String name;
  String infor;
  int type;
  Station(this.img, this.name, this.infor, this.type);
}
