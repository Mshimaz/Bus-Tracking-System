import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SpeedometerScreen extends StatefulWidget {
  @override
  _SpeedometerScreenState createState() => _SpeedometerScreenState();
}

class _SpeedometerScreenState extends State<SpeedometerScreen> {
  double _speed = 0.0;
  AccelerometerEvent? _accelerometerEvent;
  bool _exceedsLimit = false;
  Timer? _timer;
  void speedCheck() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _speed = position.speed * 3.6;
    setState(() {
      _exceedsLimit = _speed > 16.67; // 60 km/h in m/s
    });
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerEvent = event;
      });
      speedCheck();
    });
    _startTimer();
  }

  void _startTimer() {
    const tenMinutes = Duration(minutes: 10);
    _timer = Timer(tenMinutes, () {
      setState(() {
        _timer = null;
      });
      _showAlert();
    });
  }

  void _showAlert() async {
    if (_exceedsLimit) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      var androidSettings = AndroidInitializationSettings('app_icon');
      var initSettings = InitializationSettings(android: androidSettings);
      flutterLocalNotificationsPlugin.initialize(initSettings);
      var androidDetails = AndroidNotificationDetails(
          'Speed Limit Exceeded', 'Speed Limit Exceeded',
          //'Alerts when the speed limit is exceeded',
          importance: Importance.max);
      var platformDetails = NotificationDetails(android: androidDetails);
      await flutterLocalNotificationsPlugin.show(0, 'Speed Limit Exceeded',
          'You have exceeded the speed limit of 60 km/h', platformDetails,
          payload: 'Speed Limit Exceeded');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speedometer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current Speed:',
            ),
            Text(
              '${_speed.toStringAsFixed(1)} km/h',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          double speed = position.speed;
          setState(() {
            _speed = speed;
            _exceedsLimit = _speed > 16.67; // 60 km/h in m/s
          });
        },
        tooltip: 'Get Speed',
        child: Icon(Icons.speed),
      ),
    );
  }
}
