import 'package:farmfusion/Screens/login_screen.dart';
import 'package:farmfusion/Widgets/adminNavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:farmfusion/Widgets/navbar.dart';

class CheckUserLogin extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.ref().child("Users").child("role");

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return LoginScreen();
    } else {
      return FutureBuilder(
        future: dbRef.once(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final Map<dynamic, dynamic>? roles = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;
            final uid = user.uid;

            if (roles != null && roles.containsKey("Admin") && roles["Admin"] == uid) {
              return adminNavbar();
            } else {
              return Navbar();
            }
          }
        },
      );
    }
  }
}
