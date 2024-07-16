import 'package:farmfusion/Routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Farm Fusion",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: "LocalFont",
            color: Colors.white,
            letterSpacing: 1
        ),),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Log Out"),
          onPressed: (){
            FirebaseAuth.instance.signOut();
            Get.offAllNamed(RoutesName.loginScreen.toString());
          },
        ),
      ),
    );
  }
}