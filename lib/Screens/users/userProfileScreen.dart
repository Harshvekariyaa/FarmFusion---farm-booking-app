import 'package:farmfusion/Screens/users/userHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';

class userProfileScreen extends StatefulWidget {
  const userProfileScreen({super.key});

  @override
  State<userProfileScreen> createState() => _userProfileScreenState();
}

class _userProfileScreenState extends State<userProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade500,
        title: Text("User Profile Screen",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0,left: 5,right: 5),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: [
                      Icon(Icons.person,color: Colors.green.shade900,size: 150,),
                      Text("Hello, User",style: TextStyle(color: Colors.green.shade900,fontSize: 23),)
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 39.0,right: 38.0,bottom: 4),
                child: Container(
                  color: Colors.green.shade300,
                  child: InkWell(
                    onTap: (){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("About Us")));
                    },
                    child: ListTile(
                      hoverColor: Colors.green.shade500,
                      leading: Icon(Icons.details,color: Colors.white,),
                      title: Text("About us",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 38.0),
                child: Container(
                  color: Colors.green.shade300,
                  child: InkWell(
                    onTap: (){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Contact us")));
                    },
                    child: ListTile(
                      hoverColor: Colors.green.shade500,
                      leading: Icon(Icons.call,color: Colors.white),
                      title: Text("Contact us",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36.0,horizontal: 38.0),
                child: Container(
                  color: Colors.red.shade300,
                  child: InkWell(
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                    },
                    child: ListTile(
                      hoverColor: Colors.red,
                      leading: Icon(Icons.logout_sharp,color: Colors.white),
                      title: Text("Log Out",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
