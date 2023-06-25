import 'package:bus_track/Screens/scanTicketScreen.dart';
import 'package:bus_track/Screens/speedDetectingScreen.dart';
import 'package:bus_track/Screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/textExtractionScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BUS TRACK',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const SplashScreen(),
    );
  }
}
