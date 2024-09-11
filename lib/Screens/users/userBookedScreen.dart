import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userBookedScreen extends StatefulWidget {
  @override
  _userBookedScreenState createState() => _userBookedScreenState();
}

class _userBookedScreenState extends State<userBookedScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  // Fetch current user details
  void getCurrentUser() {
    currentUser = _auth.currentUser;
    if (currentUser == null) {
      print("No user logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: Text('Booked Farms', style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
      ),
      body: currentUser == null
          ? Center(child: Text('No user is logged in'))
          : StreamBuilder(
        stream: _firestore
            .collection('farms') // Your collection name
            .where('userEmail', isEqualTo: currentUser!.email) // Match by user email
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available for this user'));
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

              return Card(
                color: Colors.grey.shade300,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        data['imageUrl'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      Text(
                        data['name'],
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      SizedBox(height: 5),
                      Text('Location: ${data['location']}',
                          style: TextStyle(fontSize: 16)),
                      Text('Price: ₹${data['price']}',
                          style: TextStyle(fontSize: 16)),
                      Text('Owner: ${data['ownerName']}',
                          style: TextStyle(fontSize: 16)),
                      Text('Contact: ${data['ownerNumber']}',
                          style: TextStyle(fontSize: 16)),
                      Text('Payment Method: ${data['paymentMethod']}',
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Text('Description: ${data['description']}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
