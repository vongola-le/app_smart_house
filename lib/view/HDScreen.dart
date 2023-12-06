import 'package:app_smart_house/view/SignInScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HDScreen extends StatefulWidget {
  const HDScreen({super.key});

  @override
  State<HDScreen> createState() => _HDScreenState();
}

class _HDScreenState extends State<HDScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.blue,
        child: const Text(
          'S K I P',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/trangChu.jpg'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/trangChuPhong.jpg'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/trangThietBi.jpg'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/trangThietBiNut.jpg'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/trangCaNhan.jpg'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/trangChonPhongTB.jpg'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/trangThemThietBi.jpg'),
                ),
              ],
              options: CarouselOptions(
                initialPage: 0,
                viewportFraction: 2.0,
                enableInfiniteScroll: false,
                reverse: false,
                enlargeCenterPage: true,
                enlargeFactor: 0,
                scrollDirection: Axis.horizontal,
                height: MediaQuery.of(context).size.height - 30,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                7, // Số lượng slides
                (index) => buildDot(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index ? Colors.cyan : Colors.grey,
        ),
      ),
    );
  }
}
