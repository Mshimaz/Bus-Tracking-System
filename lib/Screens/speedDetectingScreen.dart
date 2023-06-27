import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:geolocator/geolocator.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:lottie/lottie.dart';

class SpeedometerScreen extends StatefulWidget {
  String busNo;
  String route;
  SpeedometerScreen({required this.busNo, required this.route});
  @override
  _SpeedometerScreenState createState() => _SpeedometerScreenState();
}

class _SpeedometerScreenState extends State<SpeedometerScreen> {
  double _speed = 0.0;
  AccelerometerEvent? _accelerometerEvent;
  bool _exceedsLimit = false;
  bool _sendMessage = true;
  Timer? _timer;

  // Future<void> sendEmail() async {
  //   const String sendGridApiKey =
  //       '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';
  //   const String url = 'https://api.sendgrid.com/v3/mail/send';

  //   Map<String, dynamic> data = {
  //     'personalizations': [
  //       {
  //         'to': [
  //           {'email': 'shijupp0007@gmail.com'}
  //         ],
  //         'subject': 'Test email'
  //       }
  //     ],
  //     'from': {'email': 'busreport123@gmail.com'},
  //     'content': [
  //       {
  //         'type': 'text/plain',
  //         'value': 'The bus ${widget.busNo} have exceeded the speed limit!'
  //       }
  //     ]
  //   };

  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       'Authorization': 'Bearer $sendGridApiKey',
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(data),
  //   );

  //   if (response.statusCode == 202) {
  //     print('Email sent successfully.');
  //   } else {
  //     print('Failed to send email. Response: ${response.body}');
  //   }
  // }

  // void sendEmail() async {
  //   String username = 'busreport123@gmail.com';
  //   String password = 'Busreport@123';
  //   final smtpServer = gmail(username, password);

  //   final message = Message()
  //     ..from = Address(username, 'Bus Report')
  //     ..recipients.add('shijupp0007@gmail.com')
  //     ..subject = 'Overspeed detected'
  //     ..text = 'The bus ${widget.busNo} have exceeded the speed limit!';

  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ' + sendReport.toString());
  //   } on MailerException catch (e) {
  //     print('Error: ${e.toString()}');
  //   }
  // }

  void speedCheck() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _speed = position.speed * 3.6;
    setState(() {
      _exceedsLimit = _speed > 30;
      _sendMessage = _speed > 30; //16.67; // 60 km/h in m/s
    });
    if (_sendMessage && _speed > 30) {
      //sendEmail();
      List<String> recipients = ['+918138981292'];
      String message = 'The bus ${widget.busNo} have exceeded the speed limit!';
      try {
        await sendSMS(
          message: message,
          recipients: recipients,
        );
        print('SMS sent successfully');
      } catch (e) {
        print('Error sending SMS: $e');
      }
      setState(() {
        _sendMessage = false;
      });
    }
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
    //_startTimer();
  }

  // void _startTimer() {
  //   const tenMinutes = Duration(minutes: 10);
  //   _timer = Timer(tenMinutes, () {
  //     setState(() {
  //       _timer = null;
  //     });
  //     //_showAlert();
  //   });
  // }

  // void _showAlert() async {
  //   if (_exceedsLimit) {
  //     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //         FlutterLocalNotificationsPlugin();
  //     var androidSettings = AndroidInitializationSettings('app_icon');
  //     var initSettings = InitializationSettings(android: androidSettings);
  //     flutterLocalNotificationsPlugin.initialize(initSettings);
  //     var androidDetails = AndroidNotificationDetails(
  //         'Speed Limit Exceeded', 'Speed Limit Exceeded',
  //         //'Alerts when the speed limit is exceeded',
  //         importance: Importance.max);
  //     var platformDetails = NotificationDetails(android: androidDetails);
  //     await flutterLocalNotificationsPlugin.show(0, 'Speed Limit Exceeded',
  //         'You have exceeded the speed limit of 60 km/h', platformDetails,
  //         payload: 'Speed Limit Exceeded');
  //   }
  // }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Speed Tracking',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            height: 36,
            margin: EdgeInsets.only(left: 10, right: 10),
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(202, 135, 231, 255)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bus No: ${widget.busNo}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff4480F4)),
                  ),
                  Text(
                    'Route: ${widget.route}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff4480F4)),
                  )
                ]),
          ),
          Text('Speed limit: 30km/hr'),
          SizedBox(
            height: 200,
          ),
          const Text(
            'Current Speed:',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            '${_speed.toStringAsFixed(1)}km/h',
            style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: _exceedsLimit ? Colors.red : Colors.black),
          ),
          _exceedsLimit
              ? Container(
                  height: 28,
                  width: 108,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(232, 255, 129, 129)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/images/danger.png'),
                      const Text(
                        "Overspeed",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          Lottie.asset('assets/images/34600-bus-ticket.json')
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     Position position = await Geolocator.getCurrentPosition(
      //         desiredAccuracy: LocationAccuracy.high);
      //     double speed = position.speed;
      //     setState(() {
      //       _speed = speed;
      //       _exceedsLimit = _speed > 0.277778; //16.67; // 60 km/h in m/s
      //     });
      //   },
      //   tooltip: 'Get Speed',
      //   child: Icon(Icons.speed),
      // ),
    );
  }
}
