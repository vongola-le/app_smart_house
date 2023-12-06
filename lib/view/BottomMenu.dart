import 'package:app_smart_house/view/AllDeviceScreen.dart';
import 'package:app_smart_house/view/ProfileScreen.dart';
import 'package:app_smart_house/view/HomeScreen.dart';
import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  BottomMenu({
    Key? key,
  });

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int current_index = 0;

  final pages = [
    const HomeScreen(),
    const AllDevices(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[current_index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF0597F2),
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            tooltip: "Trang chủ",
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            tooltip: "Tất cả thiết bị",
            label: "Tất cả thiết bị",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            tooltip: "Trang cá nhân",
            label: "Trang cá nhân",
          ),
        ],
        currentIndex: current_index,
        onTap: (index) {
          setState(() {
            current_index = index;
          });
        },
      ),
    );
  }
}
