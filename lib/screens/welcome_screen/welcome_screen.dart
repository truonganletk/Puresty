import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Puresty',
      home: Scaffold(
        body: Column(
          children: [
            Container(
              width: 300,
              height: 400,
              child: SvgPicture.asset(
                  'assets/images/undraw_my_personal_files_re_3q0p.svg')),
            Container(
            height: 45.0,
            child: Center(
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      fontFamily: "SanFrancisco",
                      fontSize: 40.0,
                      fontWeight: FontWeight.w300),
            )),
            ),
            Container(
            height: 100.0,
            child: Center(
                child: Text(
                  "An apple a day keeps the doctor away” \n Puresty keeps you pure everyday.",
                  style: TextStyle(
                      fontFamily: "SanFrancisco",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
            )),
            ),
            FlatButton (
              child: Text("Get started"),
              onPressed: () {},
              color: Colors.green,
              textColor: Colors.white,
            )
          ]
        ),
      ),
    );
  }
}

