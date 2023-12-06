import 'package:app_smart_house/view/SignInScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Picture(),
    );
  }
}

final List<String> imgList = [
  'assets/img/1.png',
  'assets/img/2.png',
  'assets/img/3.png'
];

class Picture extends StatefulWidget {
  const Picture({Key? key}) : super(key: key);

  @override
  State<Picture> createState() => _TrangThaiState();
}

class _TrangThaiState extends State<Picture> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          enlargeCenterPage: false,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        items: imgList
            .map((item) => Container(
                  child: Center(
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                ))
            .toList(),
      ),
      if (_currentIndex == imgList.length - 1)
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                borderRadius: BorderRadius.circular(50),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Container(
                    width: 250,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: const Color(0xFF0597F2),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          shadows: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                              spreadRadius: 5,
                            ),
                            // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    ]);
  }
}
