import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FarmDetailPage extends StatefulWidget {
  final Map<String, dynamic> farm;

  const FarmDetailPage({Key? key, required this.farm}) : super(key: key);

  @override
  State<FarmDetailPage> createState() => _FarmDetailPageState();
}

class _FarmDetailPageState extends State<FarmDetailPage> {
  String selectedPaymentMethod = 'COD'; // Default payment method
  bool _isLoading = false; // Variable to manage loading state

  // Function to handle payment method selection
  void _selectPaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  // Function to show the confirmation dialog
  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss.
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Booking'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to book this farm?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop(); // Dismiss confirmation dialog
                await _addDataToFirestore();
                if (!_isLoading) { // Check if loading is done
                  _showSuccessDialog();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show the success dialog
  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss.
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Farm booked successfully!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss success dialog
                Navigator.of(context).pop(); // Dismiss farm detail page
              },
            ),
          ],
        );
      },
    );
  }

  // Function to add data to Firestore
  Future<void> _addDataToFirestore() async {
    setState(() {
      _isLoading = true; // Set loading to true
    });

    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;

      await firestore.collection('farms').add({
        'imageUrl': widget.farm['imageUrl'] ?? '',
        'name': widget.farm['name'] ?? 'Unknown',
        'price': widget.farm['price']?.toString() ?? 'N/A',
        'description': widget.farm['description'] ?? 'No description',
        'location': widget.farm['location'] ?? 'Unknown',
        'ownerName': 'Mr. xyz abc',
        'ownerNumber': '+91 98765 43210',
        'paymentMethod': selectedPaymentMethod,
        'userEmail': user?.email ?? 'Unknown', // Store current user's email
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add data: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false after operation is complete
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.farm['name'] ?? 'Unknown';
    final String price = widget.farm['price']?.toString() ?? 'N/A';
    final String location = widget.farm['location'] ?? 'Unknown';
    final String description = widget.farm['description'] ?? 'No description';
    final String imageUrl = widget.farm['imageUrl'] ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Farm Details Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: imageUrl.isNotEmpty
                        ? Image.network(imageUrl, fit: BoxFit.cover)
                        : Center(child: Text('No Image', style: TextStyle(fontSize: 24))),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('• $name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green[800])),
                      ),
                      Text('Rs. $price', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green[800])),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('• Description: $description', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('• Location: $location', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),

                  Text(
                    '• Owner Contact:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Mr. xyz abc'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('+91 98765 43210'),
                  ),
                  SizedBox(height: 16),

                  Text(
                    'Select Payment Method:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _selectPaymentMethod('COD'),
                        child: Text('COD',style: TextStyle(color: Colors.white,fontSize: 17)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedPaymentMethod == 'COD' ? Colors.green[700] : Colors.grey,
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectPaymentMethod('Credit/Debit Card'),
                        child: Text('Card',style: TextStyle(color: Colors.white,fontSize: 17)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedPaymentMethod == 'Credit/Debit Card' ? Colors.green[700] : Colors.grey,
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectPaymentMethod('UPI'),
                        child: Text('UPI',style: TextStyle(color: Colors.white,fontSize: 17)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedPaymentMethod == 'UPI' ? Colors.green[700] : Colors.grey,
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _showConfirmationDialog,
                      child: Text('Book Now', style: TextStyle(fontSize: 20, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                ],
              ),
            ),
          ),
          if (_isLoading) // Show progress indicator if loading
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
