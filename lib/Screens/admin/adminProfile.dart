import 'package:farmfusion/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class adminProfile extends StatefulWidget {
  const adminProfile({super.key});

  @override
  State<adminProfile> createState() => _adminProfileState();
}

class _adminProfileState extends State<adminProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade500,
        title: Text("Admin Profile",style: TextStyle(color: Colors.white),),
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
                      Text("Hello, Admin",style: TextStyle(color: Colors.green.shade900,fontSize: 23),)
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

                    },
                    child: ListTile(
                      hoverColor: Colors.green.shade500,
                      leading: Icon(Icons.person,color: Colors.white,),
                      title: Text("Details",style: TextStyle(color: Colors.white),),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
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

                    },
                    child: ListTile(
                      hoverColor: Colors.green.shade500,
                      leading: Icon(Icons.add,color: Colors.white),
                      title: Text("Add farm",style: TextStyle(color: Colors.white),),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
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

                    },
                    child: ListTile(
                      hoverColor: Colors.green.shade500,
                      leading: Icon(Icons.book,color: Colors.white),
                      title: Text("Booked",style: TextStyle(color: Colors.white),),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
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
                      trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
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
