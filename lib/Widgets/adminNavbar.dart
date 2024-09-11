import 'package:farmfusion/Screens/admin/addfarmscreen.dart';
import 'package:farmfusion/Screens/admin/adminProfile.dart';
import 'package:farmfusion/Screens/admin/adminhomescreen.dart';
import 'package:farmfusion/Screens/admin/bookedfarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class adminNavbarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

class adminNavbar extends StatelessWidget {
  final adminNavbarController navbarController = Get.put(adminNavbarController());

  final screens = [
    AdminHomeScreen(),
    bookedFarm(),
    AddFarmScreen(),
    adminProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => screens[navbarController.selectedIndex.value]),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            fontFamily: "LocalFont",
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: "LocalFont",
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          currentIndex: navbarController.selectedIndex.value,
          onTap: navbarController.changeIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.details), label: "Farm details"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "add Farm"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
