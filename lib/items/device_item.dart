import 'package:app_smart_house/view/AllDeviceScreen.dart';
import 'package:app_smart_house/model/DataServiceDevice.dart';
import 'package:app_smart_house/model/DeviceData.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DeviceItem extends StatefulWidget {
  DeviceItem({super.key, required this.device});
  Device device;

  @override
  State<DeviceItem> createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  @override
  Widget build(BuildContext context) {
    double effect = widget.device.effect.toDouble();

    return GestureDetector(
      onDoubleTap: () {
        openDialogUpdate(context, widget.device);
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                  'Bạn có chắc chắn muốn xóa thiết bị ${widget.device.name}?'),
              content: Text(
                  'Điều này sẽ loại bỏ thiết bị ra khỏi danh sách thiết bị của bạn!'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text('Yes',
                          style: TextStyle(color: Colors.blue, fontSize: 18)),
                      onPressed: () {
                        DatabaseServiceDevice.delData(widget.device);
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Text('Xóa thành công!',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 140, 238, 143))),
                                  Icon(
                                    Icons.check_circle_outlined,
                                    color: const Color.fromARGB(
                                        255, 140, 238, 143),
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
                    TextButton(
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 215, 230, 236)),
          child: Padding(
              padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
              child: Column(
                children: [
                  if (widget.device.type == 0)
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.lightbulb_outlined, size: 50),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.device.name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        widget.device.room,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blueGrey),
                                      )
                                    ]),
                              )
                            ],
                          ),
                          Switch(
                            value: widget.device.status == 0 ? false : true,
                            activeColor: Color(0xFF0597F2),
                            onChanged: (bool value) {
                              setState(() {
                                widget.device.status = value ? 1 : 0;
                              });
                              DatabaseServiceDevice.updateData(widget.device);
                            },
                          ),
                        ])
                  else if (widget.device.type == 1)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.light_rounded, size: 50),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.device.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        widget.device.room,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Độ sáng: ${effect.toString()}",
                              style: const TextStyle(fontSize: 17),
                            ),
                            Switch(
                              value: widget.device.status == 0 ? false : true,
                              activeColor: Color(0xFF0597F2),
                              onChanged: (bool value) {
                                setState(() {
                                  widget.device.status = value ? 1 : 0;
                                });
                                DatabaseServiceDevice.updateData(widget.device);
                              },
                            ),
                          ],
                        ),
                        if (widget.device.status == 1)
                          Slider(
                            value: widget.device.effect.toDouble(),
                            min: 15,
                            max: 255,
                            divisions: 16,
                            label: widget.device.effect.toDouble().toString(),
                            activeColor: Colors.blue,
                            inactiveColor: Colors.grey,
                            onChanged: (value) {
                              setState(() {
                                widget.device.effect = value.toInt();
                                effect = value;
                              });
                              DatabaseServiceDevice.updateData(widget.device);
                            },
                          ),
                      ],
                    )
                  else if (widget.device.type == 2)
                    Column(
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.garage_outlined, size: 50),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.device.name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            widget.device.room,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blueGrey),
                                          )
                                        ]),
                                  )
                                ],
                              ),
                              Switch(
                                value: widget.device.status == 0 ? false : true,
                                activeColor: Color(0xFF0597F2),
                                onChanged: (bool value) {
                                  setState(() {
                                    widget.device.status = value ? 1 : 0;
                                  });
                                  DatabaseServiceDevice.updateData(
                                      widget.device);
                                },
                              ),
                            ]),
                      ],
                    )
                  else if (widget.device.type == 3)
                    Column(
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.screenshot_monitor_outlined,
                                      size: 50),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.device.name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            widget.device.room,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blueGrey),
                                          )
                                        ]),
                                  )
                                ],
                              ),
                              Switch(
                                value: widget.device.status == 0 ? false : true,
                                activeColor: Color(0xFF0597F2),
                                onChanged: (bool value) {
                                  setState(() {
                                    widget.device.status = value ? 1 : 0;
                                  });
                                  DatabaseServiceDevice.updateData(
                                      widget.device);
                                },
                              ),
                            ]),
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: MediaQuery.of(context).size.width - 35,
                            height: 60,
                            child: Text(
                              widget.device.data,
                              style: TextStyle(fontSize: 18),
                            ))
                      ],
                    )
                ],
              )),
        ),
      ),
    );
  }
}

Future<void> openDialogUpdate(BuildContext context, Device device) async {
  TextEditingController controller = TextEditingController(text: device.name);
  String dropdownValue = device.room;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            //title: Text('Tên thiết bị'),
            title: Text("Chỉnh sửa thông tin thiết bị ${device.name}"),
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
                          device.id_room = 0;
                        } else if (dropdownValue == 'Garage') {
                          device.id_room = 1;
                        } else if (dropdownValue == 'Phòng ăn') {
                          device.id_room = 2;
                        } else if (dropdownValue == 'Phòng ngủ') {
                          device.id_room = 3;
                        } else if (dropdownValue == 'WC') {
                          device.id_room = 4;
                        }
                        device.room = dropdownValue;
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
                child: Text('Sửa'),
                onPressed: () {
                  device.room = dropdownValue;
                  device.name = controller.text.toString();
                  DatabaseServiceDevice.updateData(device);
                  Navigator.of(context).pop(controller.text);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Sửa thành công!',
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
