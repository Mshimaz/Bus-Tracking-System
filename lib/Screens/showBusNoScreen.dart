import 'package:flutter/material.dart';

class ShowBusNumberScreen extends StatefulWidget {
  String busNumber;
  ShowBusNumberScreen({super.key, required this.busNumber});

  @override
  State<ShowBusNumberScreen> createState() => _ShowBusNumberScreenState();
}

class _ShowBusNumberScreenState extends State<ShowBusNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Bus Number : ${widget.busNumber}")),
    );
  }
}
