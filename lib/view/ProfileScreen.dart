// import 'package:app_smart_house/model/user.dart';
// import 'package:app_smart_house/view/BottomMenu.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Profile extends StatefulWidget {
//   Profile({
//     super.key,
//     // Truyền ID người dùng vào đây
//     // required this.id
//   });
//   int id = 1;
//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   List<Users> lst_users = [];
//   Users user = Users(0, "", "", "", "", "", "", "", "", "");
//   @override
//   void initState() {
//     super.initState();
//     Users.loadData().then((value) {
//       setState(() {
//         lst_users = Users.users;
//         for (var us in lst_users) {
//           if (us.id == widget.id) {
//             user = us;
//           }
//         }
//       });
//     });
//   }

//   // sign user out method
//   void signOut() {
//     FirebaseAuth.instance.signOut();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF5BA9D9),
//           title: const Text('Trang Cá Nhân'),
//         ),
//         bottomSheet: null,
//         body: ListView(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 10.0),
//                 CircleAvatar(
//                   backgroundImage: NetworkImage((user.img != ""
//                       ? user.img
//                       : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOH2aZnIHWjMQj2lQUOWIL2f4Hljgab0ecZQ&usqp=CAU")),
//                   radius: 80.0,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.black, width: 2.0),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsetsDirectional.all(10),
//                   child: Container(
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                           width: 2.0,
//                         ),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: UserInfoItem(user: user)),
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Row(
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.all(5),
//                                 child: Text("Tài khoản liên kết",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 25)),
//                               ),
//                               Container(
//                                   width: MediaQuery.of(context).size.width - 20,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                           width: 2, color: Colors.black),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: const Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         ShareInfoItem(text: "Lý Anh Hào"),
//                                         ShareInfoItem(text: "Lê Hoàng Đệ"),
//                                         ShareInfoItem(text: "Lê Ngọc Bá Thông"),
//                                         ShareInfoItem(
//                                             text: "Nguyễn Thị Cẩm Duyên"),
//                                         Icon(
//                                           Icons.add_circle,
//                                           size: 35,
//                                           color: Color.fromARGB(
//                                               255, 148, 236, 151),
//                                         )
//                                       ],
//                                     ),
//                                   ))
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: Center(
//                 child: ElevatedButton(
//                   onPressed: signOut,
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(200, 50),
//                     backgroundColor: Color.fromARGB(255, 252, 77, 77),
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(50),
//                       ),
//                     ),
//                   ),
//                   child: const Text(
//                     'Log Out',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
// }

// class UserInfoItem extends StatefulWidget {
//   UserInfoItem({super.key, required this.user});
//   Users user;

//   @override
//   State<UserInfoItem> createState() => _UserInfoItemState();
// }

// enum Sex { male, female, unknow }

// class _UserInfoItemState extends State<UserInfoItem> {
//   final CollectionReference _collectionRef =
//       FirebaseFirestore.instance.collection('users');
//   final _user = FirebaseAuth.instance.currentUser!;
//   String _Address = '';
//   String _Birthday = '';
//   String _Email = '';
//   String _Name = '';
//   String _Password = '';
//   String _Phone = '';
//   String _Sex = '';
//   String _UserID = '';

//   @override
//   void initState() {
//     super.initState();
//     getData();
//     addData();
//   }

//   final CollectionReference _users =
//       FirebaseFirestore.instance.collection('users');

//   Future<void> addData() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     final String email = currentUser!.email ?? '';
//     String docId = _user.email ?? email;
//     try {
//       // Kiểm tra xem tài liệu có tồn tại không
//       var snapshot = await _collectionRef.doc(_user.email).get();
//       if (snapshot.exists) {
//         // Nếu tài liệu đã tồn tại, cập nhật dữ liệu mới
//         await _collectionRef.doc(docId).update({
//           'Address': _Address,
//           'Birthday': _Birthday,
//           'Email': docId,
//           'Name': _Name,
//           'Password': _Password,
//           'Phone': _Phone,
//           'Sex': _Sex,
//           'UserID': _UserID,
//         });
//       } else {
//         // Nếu tài liệu chưa tồn tại, tạo một tài liệu mới
//         await _collectionRef.doc(docId).set({
//           'Address': _Address,
//           'Birthday': _Birthday,
//           'Email': docId,
//           'Name': _Name,
//           'Password': _Password,
//           'Phone': _Phone,
//           'Sex': _Sex,
//           'UserID': _UserID,
//         });
//       }
//       print('Data added successfully');
//     } catch (e) {
//       print('Error adding data: $e');
//     }
//   }

//   Future<void> getData() async {
//     QuerySnapshot querySnapshot;

//     try {
//       querySnapshot = await _collectionRef.where(_user.email as Object).get();

//       if (querySnapshot.docs.isNotEmpty) {
//         for (var doc in querySnapshot.docs) {
//           print('Document data: ${doc.data()}');
//           var data = doc.data() as Map<String, dynamic>;
//           var address = data?['Address'];
//           var birthday = data?['Birthday'];
//           var email = data?['Email'];
//           var name = data?['Name'];
//           var pass = data?['Password'];
//           var phone = data?['Phone'];
//           var sex = data?['Sex'];
//           var userid = data?['UserID'];

//           setState(() {
//             _Address = address;
//             _Birthday = birthday;
//             _Email = email;
//             _Name = name;
//             _Password = pass;
//             _Phone = phone;
//             _Sex = sex;
//             _UserID = userid;
//           });
//         }
//       } else {
//         print('Document does not exist on the database');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   final nameController = TextEditingController();
//   final birthdayController = TextEditingController();
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();
//   final passController = TextEditingController();
//   final addressController = TextEditingController();

//   Future<void> updateUser(String name) async {
//     QuerySnapshot querySnapshot =
//         await _users.where('Email', isEqualTo: _Email).get();
//     if (querySnapshot.docs.isNotEmpty) {
//       querySnapshot.docs.first.reference
//           .update({'Name': name})
//           .then((value) => print("User Updated"))
//           .catchError((error) => print("Failed to update user: $error"));
//     } else {
//       print('No user found with the provided email');
//     }
//   }

//   Future<void> updateBirthday(String birthday) async {
//     QuerySnapshot querySnapshot =
//         await _users.where('Email', isEqualTo: _Email).get();
//     if (querySnapshot.docs.isNotEmpty) {
//       querySnapshot.docs.first.reference
//           .update({'Birthday': birthday})
//           .then((value) => print("Birthday Updated"))
//           .catchError((error) => print("Failed to update birthday: $error"));
//     } else {
//       print('No user found with the provided email');
//     }
//   }

//   Future<void> updatePhone(String phone) async {
//     QuerySnapshot querySnapshot =
//         await _users.where('Email', isEqualTo: _Email).get();
//     if (querySnapshot.docs.isNotEmpty) {
//       querySnapshot.docs.first.reference
//           .update({'Phone': phone})
//           .then((value) => print("Phone Updated"))
//           .catchError((error) => print("Failed to update phone: $error"));
//     } else {
//       print('No user found with the provided email');
//     }
//   }

//   Future<void> updateEmail(String email) async {
//     QuerySnapshot querySnapshot =
//         await _users.where('Email', isEqualTo: _Email).get();
//     if (querySnapshot.docs.isNotEmpty) {
//       querySnapshot.docs.first.reference
//           .update({'Email': email})
//           .then((value) => print("Email Updated"))
//           .catchError((error) => print("Failed to update email: $error"));
//     } else {
//       print('No user found with the provided email');
//     }
//   }

//   Future<void> updateAddress(String phone) async {
//     QuerySnapshot querySnapshot =
//         await _users.where('Email', isEqualTo: _Email).get();
//     if (querySnapshot.docs.isNotEmpty) {
//       querySnapshot.docs.first.reference
//           .update({'Phone': phone})
//           .then((value) => print("Phone Updated"))
//           .catchError((error) => print("Failed to update phone: $error"));
//     } else {
//       print('No user found with the provided email');
//     }
//   }

//   Future<void> updateSex(bool sex) async {
//     QuerySnapshot querySnapshot =
//         await _users.where('Email', isEqualTo: _Email).get();
//     if (querySnapshot.docs.isNotEmpty) {
//       querySnapshot.docs.first.reference
//           .update({'Sex': sex})
//           .then((value) => print("Sex Updated"))
//           .catchError((error) => print("Failed to update sex: $error"));
//     } else {
//       print('No user found with the provided email');
//     }
//   }

//   Future<void> updatePassword(String pass) async {
//     QuerySnapshot querySnapshot =
//         await _users.where('Email', isEqualTo: _Email).get();
//     if (querySnapshot.docs.isNotEmpty) {
//       querySnapshot.docs.first.reference
//           .update({'Password': pass})
//           .then((value) => print("Password Updated"))
//           .catchError((error) => print("Failed to update password: $error"));
//     } else {
//       print('No user found with the provided email');
//     }
//   }

//   void _modalBottomSheetMenu(int stt) {
//     showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           Sex? _sex = widget.user.sex == ""
//               ? Sex.unknow
//               : (widget.user.sex == "Nam" ? Sex.male : Sex.female);
//           return Column(children: [
//             if (stt == 1)
//               Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: nameController,
//                         decoration: InputDecoration(
//                             hintText: "Nhập tên người dùng mới",
//                             border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)))),
//                       ),
//                       const Padding(padding: EdgeInsets.only(top: 10)),
//                       ElevatedButton(
//                           onPressed: () {
//                             updateUser(nameController.text);
//                           },
//                           style: ButtonStyle(
//                               backgroundColor: const MaterialStatePropertyAll(
//                                   Color(0xFF0597F2)),
//                               shape: MaterialStatePropertyAll(
//                                   BeveledRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5)))),
//                           child: const Text(
//                             "Xác nhận",
//                             style: TextStyle(color: Colors.white),
//                           )),
//                     ],
//                   ))
//             // else if (stt == 2)
//             //   Padding(
//             //       padding: const EdgeInsets.all(20),
//             //       child: Column(
//             //         children: [
//             //           TextField(
//             //             decoration: InputDecoration(
//             //                 hintText: "Nhập tên tài khoản mới",
//             //                 border: const OutlineInputBorder(
//             //                     borderRadius:
//             //                         BorderRadius.all(Radius.circular(10)))),
//             //           ),
//             //           const Padding(padding: EdgeInsets.only(top: 10)),
//             //           ElevatedButton(
//             //               onPressed: () {},
//             //               child: Text(
//             //                 "Xác nhận",
//             //                 style: TextStyle(color: Colors.white),
//             //               ),
//             //               style: ButtonStyle(
//             //                   backgroundColor: const MaterialStatePropertyAll(
//             //                       Color(0xFF0597F2)),
//             //                   shape: MaterialStatePropertyAll(
//             //                       BeveledRectangleBorder(
//             //                           borderRadius:
//             //                               BorderRadius.circular(5))))),
//             //         ],
//             //       ))
//             else if (stt == 3)
//               Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: birthdayController,
//                         keyboardType: TextInputType.datetime,
//                         decoration: InputDecoration(
//                             hintText: "Nhập ngày sinh mới",
//                             border: const OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)))),
//                       ),
//                       const Padding(padding: EdgeInsets.only(top: 10)),
//                       ElevatedButton(
//                           onPressed: () {
//                             updateBirthday(birthdayController.text);
//                           },
//                           child: Text(
//                             "Xác nhận",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           style: ButtonStyle(
//                               backgroundColor: const MaterialStatePropertyAll(
//                                   Color(0xFF0597F2)),
//                               shape: MaterialStatePropertyAll(
//                                   BeveledRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(5))))),
//                     ],
//                   ))
//             else if (stt == 4)
//               Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: passController,
//                         decoration: InputDecoration(
//                             hintText: "Nhập mật khẩu mới",
//                             border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)))),
//                       ),
//                       SizedBox(height: 10),
//                       TextField(
//                         decoration: InputDecoration(
//                             hintText: "Nhập lại mật khẩu mới",
//                             border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)))),
//                       ),
//                       const Padding(padding: EdgeInsets.only(top: 10)),
//                       ElevatedButton(
//                           onPressed: () {
//                             updatePassword(passController.text);
//                           },
//                           child: Text(
//                             "Xác nhận",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           style: ButtonStyle(
//                               backgroundColor: const MaterialStatePropertyAll(
//                                   Color(0xFF0597F2)),
//                               shape: MaterialStatePropertyAll(
//                                   BeveledRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(5))))),
//                     ],
//                   ))
//             else if (stt == 5)
//               Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: phoneController,
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                             hintText: "Nhập số điện thoại mới",
//                             border: const OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)))),
//                       ),
//                       const Padding(padding: EdgeInsets.only(top: 10)),
//                       ElevatedButton(
//                           onPressed: () {
//                             updatePhone(phoneController.text);
//                           },
//                           child: Text(
//                             "Xác nhận",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           style: ButtonStyle(
//                               backgroundColor: const MaterialStatePropertyAll(
//                                   Color(0xFF0597F2)),
//                               shape: MaterialStatePropertyAll(
//                                   BeveledRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(5))))),
//                     ],
//                   ))
//             else if (stt == 6)
//               Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                             hintText: "Nhập Email mới",
//                             border: const OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)))),
//                       ),
//                       ElevatedButton(
//                           onPressed: () {
//                             updateEmail(emailController.text);
//                           },
//                           child: Text(
//                             "Xác nhận",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           style: ButtonStyle(
//                               backgroundColor: const MaterialStatePropertyAll(
//                                   Color(0xFF0597F2)),
//                               shape: MaterialStatePropertyAll(
//                                   BeveledRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(5))))),
//                     ],
//                   ))
//             else if (stt == 7)
//               Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                             hintText: "Nhập địa chỉ mới",
//                             border: const OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)))),
//                       ),
//                       ElevatedButton(
//                           onPressed: () {
//                             updateAddress(addressController.text);
//                           },
//                           child: Text(
//                             "Xác nhận",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           style: ButtonStyle(
//                               backgroundColor: const MaterialStatePropertyAll(
//                                   Color(0xFF0597F2)),
//                               shape: MaterialStatePropertyAll(
//                                   BeveledRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(5))))),
//                     ],
//                   ))
//             else if (stt == 8)
//               Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       RadioListTile<Sex>(
//                         title: const Text("Nam"),
//                         value: Sex.male,
//                         groupValue: _sex,
//                         onChanged: (Sex? value) {
//                           setState(() {
//                             _sex = value!;
//                           });
//                         },
//                       ),
//                       RadioListTile<Sex>(
//                         title: const Text("Nữ"),
//                         value: Sex.female,
//                         groupValue: _sex,
//                         onChanged: (Sex? value) {
//                           setState(() {
//                             _sex = value!;
//                           });
//                         },
//                       ),
//                       RadioListTile<Sex>(
//                         title: const Text("Không rõ"),
//                         value: Sex.unknow,
//                         groupValue: _sex,
//                         onChanged: (Sex? value) {
//                           setState(() {
//                             _sex = value!;
//                           });
//                         },
//                       ),
//                       ElevatedButton(
//                           onPressed: () {
//                             bool _chk = _sex == Sex.male ? true : false;
//                             updateSex(_chk);
//                           },
//                           child: Text(
//                             "Xác nhận",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           style: ButtonStyle(
//                               backgroundColor: const MaterialStatePropertyAll(
//                                   Color(0xFF0597F2)),
//                               shape: MaterialStatePropertyAll(
//                                   BeveledRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(5))))),
//                     ],
//                   ))
//           ]);
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Column(
//           children: [
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               Text(
//                 'Tên người dùng:',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//               ),
//               const SizedBox(width: 40.0),
//               GestureDetector(
//                 onTap: () {
//                   _modalBottomSheetMenu(1);
//                 },
//                 child: Row(children: [
//                   Text(
//                     _Name,
//                     style: const TextStyle(fontSize: 15),
//                   ),
//                   const Icon(Icons.edit_square)
//                 ]),
//               ),
//             ]),
//             const Padding(padding: EdgeInsets.only(top: 10)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('ID tài khoản:',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                 Text(
//                   _UserID,
//                   style: const TextStyle(fontSize: 15),
//                 ),
//               ],
//             ),
//             const Padding(padding: EdgeInsets.only(top: 10)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Ngày sinh:',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                 const SizedBox(width: 40.0),
//                 GestureDetector(
//                   onTap: () {
//                     _modalBottomSheetMenu(3);
//                   },
//                   child: Row(children: [
//                     Text(
//                       _Birthday,
//                       style: const TextStyle(fontSize: 15),
//                     ),
//                     const Icon(Icons.edit_square)
//                   ]),
//                 ),
//               ],
//             ),
//             const Padding(padding: EdgeInsets.only(top: 10)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Mật khẩu:',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                 const SizedBox(width: 40.0),
//                 GestureDetector(
//                   onTap: () {
//                     _modalBottomSheetMenu(4);
//                   },
//                   child: Row(children: [
//                     Text(
//                       (''),
//                       style: const TextStyle(fontSize: 15),
//                     ),
//                     const Icon(Icons.edit_square)
//                   ]),
//                 ),
//               ],
//             ),
//             const Padding(padding: EdgeInsets.only(top: 10)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Số điện thoại:',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                 const SizedBox(width: 40.0),
//                 GestureDetector(
//                   onTap: () {
//                     _modalBottomSheetMenu(5);
//                   },
//                   child: Row(children: [
//                     Text(
//                       _Phone,
//                       style: const TextStyle(fontSize: 15),
//                     ),
//                     const Icon(Icons.edit_square)
//                   ]),
//                 ),
//               ],
//             ),
//             const Padding(padding: EdgeInsets.only(top: 10)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Email:',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                 const SizedBox(width: 40.0),
//                 GestureDetector(
//                   onTap: () {
//                     _modalBottomSheetMenu(6);
//                   },
//                   child: Row(children: [
//                     Text(
//                       _Email = _user.email.toString(),
//                       style: const TextStyle(fontSize: 15),
//                     ),
//                     // const Icon(Icons.edit_square)
//                   ]),
//                 ),
//               ],
//             ),
//             const Padding(padding: EdgeInsets.only(top: 10)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Địa chỉ:',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                 const SizedBox(width: 40.0),
//                 GestureDetector(
//                   onTap: () {
//                     _modalBottomSheetMenu(7);
//                   },
//                   child: Row(children: [
//                     Text(
//                       _Address,
//                       style: const TextStyle(fontSize: 15),
//                     ),
//                     const Icon(Icons.edit_square)
//                   ]),
//                 ),
//               ],
//             ),
//             const Padding(padding: EdgeInsets.only(top: 10)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Giới tính:',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                 const SizedBox(width: 40.0),
//                 GestureDetector(
//                   onTap: () {
//                     _modalBottomSheetMenu(8);
//                   },
//                   child: Row(children: [
//                     Text(
//                       _Sex,
//                       style: const TextStyle(fontSize: 15),
//                     ),
//                     const Icon(Icons.edit_square)
//                   ]),
//                 ),
//               ],
//             ),
//           ],
//         ));
//   }
// }

// class ShareInfoItem extends StatelessWidget {
//   final String text;
//   const ShareInfoItem({
//     super.key,
//     required this.text,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text('  $text',
//               style:
//                   const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//           const SizedBox(width: 40.0),
//           GestureDetector(
//             onTap: null,
//             child: const Row(children: [
//               Icon(
//                 Icons.delete_forever,
//                 color: Color.fromARGB(255, 245, 142, 135),
//                 size: 30,
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:app_smart_house/provider/google_sign_in.dart';
import 'package:app_smart_house/view/HDScreen.dart';
import 'package:app_smart_house/model/DataServiceUser.dart';
import 'package:app_smart_house/model/User.dart';
import 'package:app_smart_house/model/UserData.dart';
import 'package:app_smart_house/view/BottomMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({
    super.key,
  });
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<User2> lst_users = [];
  User2 user = User2(
      id: 0,
      img: "",
      name: "",
      account: "",
      date: "",
      password: "",
      phone: "",
      email: "",
      address: "",
      sex: "");
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _setupUsers();
  }

  _setupUsers() async {
    final String email = currentUser!.email ?? '';
    List<User2> users2 = await DatabaseServiceUser.getUsers();
    setState(() {
      lst_users = users2;
      for (var us in lst_users) {
        if (us.account == email) {
          user = us;
        }
      }
      if (user.account == "") {
        user = User2(
            id: lst_users.length + 1,
            img: "",
            name: "",
            account: email,
            date: "",
            password: "",
            phone: "",
            email: email,
            address: "",
            sex: "");
        DatabaseServiceUser.addData(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0597F2),
          title: const Text('Trang Cá Nhân'),
          actions: [
            IconButton(
              tooltip: "Hướng dẫn sử dụng",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HDScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.help_outline_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
        bottomSheet: null,
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                CircleAvatar(
                  backgroundImage: NetworkImage((user.img != ""
                      ? user.img
                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOH2aZnIHWjMQj2lQUOWIL2f4Hljgab0ecZQ&usqp=CAU")),
                  radius: 80.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(10),
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: UserInfoItem(user: user)),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(5),
                                child: Text("Tài khoản liên kết",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width - 20,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ShareInfoItem(text: "Lý Anh Hào"),
                                        ShareInfoItem(text: "Lê Hoàng Đệ"),
                                        ShareInfoItem(text: "Lê Ngọc Bá Thông"),
                                        ShareInfoItem(
                                            text: "Nguyễn Thị Cẩm Duyên"),
                                        Icon(
                                          Icons.add_circle,
                                          size: 35,
                                          color: Color.fromARGB(
                                              255, 148, 236, 151),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.Logout();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      backgroundColor: Color.fromARGB(255, 252, 77, 77),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 20),
          ],
        ));
  }
}

class UserInfoItem extends StatefulWidget {
  UserInfoItem({super.key, required this.user});
  User2 user;

  @override
  State<UserInfoItem> createState() => _UserInfoItemState();
}

enum Sex { male, female, unknow }

class _UserInfoItemState extends State<UserInfoItem> {
  void _modalBottomSheetMenu(int stt, User2 user) {
    TextEditingController txtName = TextEditingController(text: user.name);
    TextEditingController txtDate = TextEditingController(text: user.date);
    TextEditingController txtPass = TextEditingController(text: user.password);
    TextEditingController txtPhone = TextEditingController(text: user.phone);
    TextEditingController txtAddress =
        TextEditingController(text: user.address);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          Sex? _sex = user.sex == ""
              ? Sex.unknow
              : (user.sex == "Nam" ? Sex.male : Sex.female);

          // String saimk="";
          return Column(children: [
            if (stt == 1)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: txtName,
                        decoration: InputDecoration(
                            hintText: "Nhập tên người dùng mới",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              setState(() {
                                user.name = txtName.text.toString();
                                DatabaseServiceUser.updateData(user);
                                Navigator.pop(context);
                              });
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          child: const Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ))
            else if (stt == 3)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          txtDate.text = value.toString();
                        },
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            hintText: "Nhập ngày sinh mới",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              user.date = txtDate.text.toString();
                              DatabaseServiceUser.updateData(user);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5))))),
                    ],
                  ))
            else if (stt == 4)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          txtPass.text = value.toString();
                        },
                        decoration: InputDecoration(
                            hintText: "Nhập mật khẩu mới",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (txtPass.text != "") {
                                user.password = txtPass.text.toString();
                                DatabaseServiceUser.updateData(user);
                                Navigator.pop(context);
                              }
                            });
                          },
                          child: Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5))))),
                    ],
                  ))
            else if (stt == 5)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          txtPhone.text = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Nhập số điện thoại mới",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              user.phone = txtPhone.text;
                              DatabaseServiceUser.updateData(user);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5))))),
                    ],
                  ))
            else if (stt == 7)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: txtAddress,
                        decoration: InputDecoration(
                            hintText: "Nhập địa chỉ mới",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              user.address = txtAddress.text;
                              DatabaseServiceUser.updateData(user);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5))))),
                    ],
                  ))
            else if (stt == 8)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      RadioListTile<Sex>(
                        title: const Text("Nam"),
                        value: Sex.male,
                        groupValue: _sex,
                        onChanged: (Sex? value) {
                          setState(() {
                            _sex = value;
                            user.sex = "Nam";
                            DatabaseServiceUser.updateData(user);
                            Navigator.pop(context);
                          });
                        },
                      ),
                      RadioListTile<Sex>(
                        title: const Text("Nữ"),
                        value: Sex.female,
                        groupValue: _sex,
                        onChanged: (Sex? value) {
                          setState(() {
                            _sex = value;
                            user.sex = "Nữ";
                            DatabaseServiceUser.updateData(user);
                            Navigator.pop(context);
                          });
                        },
                      ),
                      RadioListTile<Sex>(
                        title: const Text("Không rõ"),
                        value: Sex.unknow,
                        groupValue: _sex,
                        onChanged: (Sex? value) {
                          setState(() {
                            _sex = value!;
                            user.sex = "Không rõ";
                            DatabaseServiceUser.updateData(user);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ))
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tên người dùng:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(1, widget.user);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.name,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tên tài khoản:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {},
                  child: Row(children: [
                    Text(
                      widget.user.account.length > 15
                          ? widget.user.account.substring(0, 15) + "..."
                          : widget.user.account,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Padding(padding: EdgeInsets.only(left: 28))
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ngày sinh:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(3, widget.user);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.date,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Mật khẩu:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(4, widget.user);
                  },
                  child: Row(children: [
                    Text(
                      "************",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 33))
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Số điện thoại:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(5, widget.user);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.phone,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    const Icon(Icons.edit_square),
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Email:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {},
                  child: Row(children: [
                    Text(
                      widget.user.email.length > 18
                          ? widget.user.email.substring(0, 18) + "..."
                          : widget.user.email,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Padding(padding: EdgeInsets.only(left: 33))
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Địa chỉ:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(7, widget.user);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.address,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Giới tính:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(8, widget.user);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.sex,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
          ],
        ));
    ;
  }
}

class ShareInfoItem extends StatelessWidget {
  final String text;
  const ShareInfoItem({
    super.key,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('  $text',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(width: 40.0),
          GestureDetector(
            onTap: null,
            child: const Row(children: [
              Icon(
                Icons.delete_forever,
                color: Color.fromARGB(255, 245, 142, 135),
                size: 30,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
