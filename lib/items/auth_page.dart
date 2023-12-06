import 'package:app_smart_house/view/HDScreen.dart';
import 'package:app_smart_house/view/BottomMenu.dart';
import 'package:app_smart_house/view/IntroScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return BottomMenu();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something Went Wrong !'));
          } else {
            return const IntroScreen();
          }
        },
      ),
    );
  }
}
