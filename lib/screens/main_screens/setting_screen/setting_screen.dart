import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/services/firebase_auth.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: darkgreyblue,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(white)),
                onPressed: () {
                  context.read<FirebaseAuthentication>().signOut();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 395,
                  height: 59,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(Icons.free_breakfast_outlined,
                            color: darkgreyblue),
                      ),
                      Text(
                        "What you ate",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: darkgreyblue,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(white)),
                onPressed: () {
                  context.read<FirebaseAuthentication>().signOut();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 395,
                  height: 59,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(Icons.person, color: darkgreyblue),
                      ),
                      Text(
                        "You profile",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: darkgreyblue,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(white)),
                onPressed: () {
                  context.read<FirebaseAuthentication>().signOut();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 395,
                  height: 59,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(Icons.logout, color: darkgreyblue),
                      ),
                      Text(
                        "Log out",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: darkgreyblue,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Container(
              width: 300,
              height: 300,
              child: SvgPicture.asset(
                  'assets/images/undraw_my_personal_files_re_3q0p.svg')),
        ],
      ),
    );
  }
}
