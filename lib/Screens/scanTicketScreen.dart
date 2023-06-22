import 'package:bus_track/Screens/speedDetectingScreen.dart';
import 'package:bus_track/Screens/textExtractionScreen.dart';
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
        body: ListView(
          children: [
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '10/05/23   Kannur TO Thalassery',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'KL58 A 1616',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '10/05/23   Kannur TO Thalassery',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'KL58 A 1616',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
