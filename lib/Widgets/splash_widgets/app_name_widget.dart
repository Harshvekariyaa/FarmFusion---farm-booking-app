import 'package:flutter/material.dart';

class AppNameWidget extends StatefulWidget {
  const AppNameWidget({super.key});

  @override
  State<AppNameWidget> createState() => _AppNameWidgetState();
}

class _AppNameWidgetState extends State<AppNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
          width: 240,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    spreadRadius: 3
                )
              ]
          ),
          child: Center(
            child: Text("Farm Fusion",style: TextStyle(
                fontSize: 29,
                color: Colors.green,
                fontFamily: 'SplashFont',
                fontWeight: FontWeight.bold
            ),),
          )
      ),
    );
  }
}