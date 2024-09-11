import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child("Farms");
  List<Map<String, dynamic>> _farmsList = [];
  bool _isLoading = false;
  bool _hasData = false; // Add this flag to track if there is data

  @override
  void initState() {
    super.initState();
    _fetchFarmsData();
  }

  Future<void> _fetchFarmsData() async {
    setState(() {
      _isLoading = true;
    });

    _dbRef.onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      final List<Map<String, dynamic>> farmsList = [];

      if (dataSnapshot.exists) {
        dataSnapshot.children.forEach((farmSnapshot) {
          final farmData = Map<String, dynamic>.from(farmSnapshot.value as Map);
          farmData['key'] = farmSnapshot.key; // Store the key for editing/deleting
          farmsList.add(farmData);
        });
        setState(() {
          _hasData = farmsList.isNotEmpty; // Update the flag based on data
          _farmsList = farmsList;
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasData = false; // No data available
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _editFarm(Map<String, dynamic> farm) async {
    final nameController = TextEditingController(text: farm['name']);
    final priceController = TextEditingController(text: farm['price'].toString());
    final locationController = TextEditingController(text: farm['location']);
    final descriptionController = TextEditingController(text: farm['description']);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Farm'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await _dbRef.child(farm['key']).update({
                  'name': nameController.text,
                  'price': double.parse(priceController.text),
                  'location': locationController.text,
                  'description': descriptionController.text,
                });
                setState(() {
                  _isLoading = false;
                });
                Navigator.pop(context);
              },
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteFarm(String key) async {
    setState(() {
      _isLoading = true;
    });
    await _dbRef.child(key).remove();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade500,
        title: Text(
          "Admin Home Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : !_hasData
          ? Center(
        child: Text(
          "No farms available.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: _farmsList.length,
        itemBuilder: (context, index) {
          final farm = _farmsList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (farm['imageUrl'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        farm['imageUrl'],
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 10),
                  Text(
                    "Name : " + farm['name'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Price : \$${farm['price']} / night",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Location : ${farm['location']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Description : ${farm['description']}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _editFarm(farm);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteFarm(farm['key']);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
