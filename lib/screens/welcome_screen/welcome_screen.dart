import 'package:flutter/material.dart';

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
            Image.asset('assets/undraw_healthy_options_sdo3.svg'),
            Text('Welcome'),
            Text('“An apple a day keeps the doctor away”  Puresty keeps you pure everyday. Get started'),
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

