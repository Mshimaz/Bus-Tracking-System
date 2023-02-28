import 'package:bus_track/Screens/textExtractionScreen.dart';
import 'package:flutter/material.dart';

class ScanTicketScreen extends StatefulWidget {
  const ScanTicketScreen({super.key});

  @override
  State<ScanTicketScreen> createState() => _ScanTicketScreenState();
}

class _ScanTicketScreenState extends State<ScanTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BUS TRACK',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: MaterialButton(
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
      )),
    );
  }
}
