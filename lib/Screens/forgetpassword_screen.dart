import 'package:farmfusion/Routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/registration_widget/customTextFeild.dart';

class forgetPasswordScreen extends StatefulWidget {
  const forgetPasswordScreen({super.key});

  @override
  State<forgetPasswordScreen> createState() => _forgetPasswordScreenState();
}

class _forgetPasswordScreenState extends State<forgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  var _isLoading = false.obs;

  forgetPass(String email){
    if(email==null){
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter valid email address")));
    }else{
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'RESET PASSWORD',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      label: 'Enter Email to reset password',
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
          
                     ElevatedButton(
                      onPressed: (){
                        forgetPass(_emailController.text.toString());
                        Get.snackbar("Link Sent", "Link sent in your email",backgroundColor: Colors.white,colorText: Colors.green.shade600);
                        Get.offNamed(RoutesName.loginScreen.toString());
          
                      },
                      child: Text('Reset Password',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
          
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

