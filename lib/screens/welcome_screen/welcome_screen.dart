import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:puresty/constants/app_colors.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                fontFamily: 'Poppins',
                color: darkgreyblue,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
        Container(
            height: 100.0,
            child: Center(
              child: Text(
                "An apple a day keeps the doctor away \n Puresty keeps you pure everyday.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: darkgreyblue,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
            )),
        Container(
          width: 305,
          height: 45,
          decoration: new BoxDecoration(
              color: dullgreen, borderRadius: BorderRadius.circular(5.75)),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(dullgreen)),
            child: Text("Get started",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xfffafdf9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                )),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ]),
    );
  }
}
