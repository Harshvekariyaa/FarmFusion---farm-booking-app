import 'package:farmfusion/Utils/utils.dart';
import 'package:farmfusion/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Routes/routes.dart';
import 'Screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FarmFusion());
}

class FarmFusion extends StatefulWidget {
  const FarmFusion({super.key});

  @override
  State<FarmFusion> createState() => _FarmFusionState();
}

class _FarmFusionState extends State<FarmFusion> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {

          if(snapshot.hasError){
            Utils().toastMessage("Something Went Wrong");
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.green,),);
          }

          if(snapshot.connectionState == ConnectionState.done){
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
              getPages: AppRoutes.appRoutes(),
            );
          }

          return Center(child: CircularProgressIndicator(color: Colors.green,),);

        }
    );
  }
}