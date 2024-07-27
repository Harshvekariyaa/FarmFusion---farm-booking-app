import 'package:farmfusion/Screens/home_screen.dart';
import 'package:farmfusion/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:farmfusion/Widgets/navbar.dart';

class checkUserLogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return LoginScreen();
    } else {
      return Navbar();
    }
  }
}
