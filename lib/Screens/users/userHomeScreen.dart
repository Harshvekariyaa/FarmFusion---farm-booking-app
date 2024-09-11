import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'bookfarm/form_detail_page.dart';

class userHomeScreen extends StatefulWidget {
  const userHomeScreen({Key? key}) : super(key: key);

  @override
  State<userHomeScreen> createState() => _userHomeScreenState();
}

class _userHomeScreenState extends State<userHomeScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child("Farms");

  List<Map<String, dynamic>> _farmList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      List<Map<String, dynamic>> farms = [];
      data.forEach((key, value) {
        farms.add(Map<String, dynamic>.from(value));
      });

      setState(() {
        _farmList = farms;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade500,
        title: Text(
          "User Home Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _farmList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _farmList.length,
              itemBuilder: (context, index) {
                final farm = _farmList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Card(
                    color: Colors.grey.shade300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 13),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: double.infinity,
                            child: Image.network(farm['imageUrl'] ?? '', fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 2),
                          child: Text(
                            'Name : ' + (farm['name'] ?? 'Unknown'),
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 2),
                          child: Text(
                            "Price : " + (farm['price']?.toString() ?? 'N/A'),
                            style: TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 2),
                          child: Text(
                            "Location : " + (farm['location'] ?? 'Unknown'),
                            style: TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 2),
                          child: Text(
                            "Description : " + (farm['description'] ?? 'No description'),
                            style: TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FarmDetailPage(
                                      farm: farm, // Pass the entire farm object
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade500,
                              ),
                              child: Text(
                                "Book Now",
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ]),

                        SizedBox(height: 13),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
