import 'package:bus_track/Screens/speedDetectingScreen.dart';
import 'package:bus_track/Screens/textExtractionScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ScanTicketScreen extends StatefulWidget {
  const ScanTicketScreen({super.key});

  @override
  State<ScanTicketScreen> createState() => _ScanTicketScreenState();
}

class _ScanTicketScreenState extends State<ScanTicketScreen> {
  Future<void> _requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.openAppSettings();
    }
  }

  final CollectionReference<Map<String, dynamic>> detailsCollection =
      FirebaseFirestore.instance.collection('details');

  @override
  Widget build(BuildContext context) {
    _requestLocationPermission();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recent Trips',
          style: TextStyle(
              color: Colors.black, fontSize: 32, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 90,
      ),
      floatingActionButton: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          color: Color(0xff4480F4),
        ),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const TicketExtractionScreen();
            }));
          },
          child: Image.asset('assets/images/scan.png'),
          backgroundColor: Color(0xff4480F4),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: detailsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No Recent Trips'));
          }

          List<DocumentSnapshot<Map<String, dynamic>>> documents =
              snapshot.data!.docs;
          if (documents.isNotEmpty) {
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${documents[index].data()!['date']}   ${documents[index].data()!['route']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '${documents[index].data()!['busNo']}',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: Text('No Recent Trips'),
            );
          }
        },
      ),
    );
  }
}
