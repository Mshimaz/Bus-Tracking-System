import 'package:bus_track/Screens/speedDetectingScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowBusNumberScreen extends StatefulWidget {
  String busNumber;
  String route;
  ShowBusNumberScreen(
      {super.key, required this.busNumber, required this.route});
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void addDetailsToFirestore(String name, int age) {
    // Get a reference to the collection you want to add the details to
    CollectionReference detailsCollection = firestore.collection('details');

    // Create a new document with a unique ID
    DocumentReference newDocument = detailsCollection.doc();

    // Set the data for the new document
    newDocument.set({
      'Number': name,
      'age': age,
    }).then((value) {
      // Success! Details added to Firestore
      print('Details added to Firestore');
    }).catchError((error) {
      // Error occurred while adding details to Firestore
      print('Error adding details to Firestore: $error');
    });
  }

  @override
  State<ShowBusNumberScreen> createState() => _ShowBusNumberScreenState();
}

class _ShowBusNumberScreenState extends State<ShowBusNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Bus Number : ${widget.busNumber} \n Route : ${widget.route}"),
          SizedBox(
            height: 5,
          ),
          MaterialButton(
            color: Color(0xff4480F4),
            height: 50,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SpeedometerScreen(
                  busNo: widget.busNumber,
                  route: widget.route,
                );
              }));
            },
            child: const Text(
              "Speed Detection",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
}
