import 'package:flutter/material.dart';

class infor_device{
  infor_device({required this.name, required this.loai ,required this.status});
  String name;
  int loai;
  bool status;

  static List<infor_device> lst_device=[
    infor_device(name: "lamp", loai: 0, status: false),
    infor_device(name: "tv", loai: 1, status: true),
  ];
}