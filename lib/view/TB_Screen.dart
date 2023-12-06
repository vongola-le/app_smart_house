import 'package:flutter/material.dart';

class Info_ThongBao extends StatelessWidget {
  const Info_ThongBao({super.key, required this.tieude, required this.noidung});
  final String? tieude;
  final String? noidung;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Text(
              '$tieude',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Text(
              '$noidung',
              style: const TextStyle(fontSize: 18.0),
            )
          ],
        ),
      ),
    );
  }
}

class TB_Screen extends StatelessWidget {
  const TB_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        backgroundColor: const Color(0xFF5BA9D9),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.all(10),
                child: Container(
                  child: const Column(
                    children: [
                      Info_ThongBao(
                          tieude: 'Thông báo 1',
                          noidung: 'Nội dung thông báo 1'),
                      Info_ThongBao(
                          tieude: 'Thông báo 2',
                          noidung: 'Nội dung thông báo 2'),
                      Info_ThongBao(
                          tieude: 'Thông báo 3',
                          noidung: 'Nội dung thông báo 3'),
                      Info_ThongBao(
                          tieude: 'Thông báo 4',
                          noidung: 'Nội dung thông báo 4'),
                      Info_ThongBao(
                          tieude: 'Thông báo 5',
                          noidung: 'Nội dung thông báo 5'),
                      Info_ThongBao(
                          tieude: 'Thông báo 6',
                          noidung: 'Nội dung thông báo 6'),
                      Info_ThongBao(
                          tieude: 'Thông báo 7',
                          noidung: 'Nội dung thông báo 7'),
                      Info_ThongBao(
                          tieude: 'Thông báo 8',
                          noidung: 'Nội dung thông báo 8'),
                      Info_ThongBao(
                          tieude: 'Thông báo 9',
                          noidung: 'Nội dung thông báo 9'),
                      Info_ThongBao(
                        tieude: 'Thông báo 10',
                        noidung: 'Nội dung thông báo 10',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
