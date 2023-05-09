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
          'BUS TRACK',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            color: Colors.black,
            height: 50,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const TicketExtractionScreen();
              }));
            },
            child: const Text(
              "Scan Ticket",
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            color: Colors.black,
            height: 50,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SpeedometerScreen();
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
