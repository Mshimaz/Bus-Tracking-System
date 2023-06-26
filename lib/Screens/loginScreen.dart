import 'package:bus_track/Screens/scanTicketScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(
            height: 100,
          ),
          Image.asset(
            "assets/images/Frame 2.png",
            height: 303.67,
            width: 379,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            '\tWelcome aboard!',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.w700),
          ),
          const Text(
            '\t\tLets get started by logging in',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color(0xff676767),
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            width: 379,
            height: 48,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffE7ECEF)),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  prefixText: '+91', border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScanTicketScreen()));
            },
            child: Container(
              height: 50,
              width: 379,
              margin: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff4480F4)),
              child: const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
