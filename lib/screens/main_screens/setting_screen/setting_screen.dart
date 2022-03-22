import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/screens/main_screens/setting_screen/food_cart_screen/food_cart_screen.dart';
import 'package:puresty/screens/main_screens/setting_screen/profile_screen/profile_screen.dart';
import 'package:puresty/services/firebase_auth.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool? isAnony = FirebaseAuth.instance.currentUser?.isAnonymous;

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
                onPressed: () async {
                  if (!isAnony!) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodCart()),
                    );
                  } else {
                    bool result = await showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Container(
                            width: 362.4,
                            height: 187,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text('Alert',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child:
                                      Text('Do you want to use this feature?',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80.15,
                                      height: 39,
                                      decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              2.457749843597412)),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    white)),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(
                                                  false); // dismisses only the dialog and returns false
                                        },
                                        child: Text('Cancel',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: dullgreen,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      ),
                                    ),
                                    Container(
                                      width: 80.15,
                                      height: 39,
                                      decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              2.457749843597412)),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    dullgreen)),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(
                                                  true); // dismisses only the dialog and returns true
                                        },
                                        child: Text('Sign In'),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    if (result)
                      context.read<FirebaseAuthentication>().signOut();
                  }
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
                onPressed: () async {
                  if (!isAnony!) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  } else {
                    bool result = await showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Container(
                            width: 362.4,
                            height: 187,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text('Alert',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child:
                                      Text('Do you want to use this feature?',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80.15,
                                      height: 39,
                                      decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              2.457749843597412)),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    white)),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(
                                                  false); // dismisses only the dialog and returns false
                                        },
                                        child: Text('Cancel',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: dullgreen,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      ),
                                    ),
                                    Container(
                                      width: 80.15,
                                      height: 39,
                                      decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              2.457749843597412)),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    dullgreen)),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(
                                                  true); // dismisses only the dialog and returns true
                                        },
                                        child: Text('Sign In'),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    if (result)
                      context.read<FirebaseAuthentication>().signOut();
                  }
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
                onPressed: () async {
                  bool result = await showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Container(
                          width: 362.4,
                          height: 187,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text('Log out',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Text('Are you sure to log out?',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80.15,
                                    height: 39,
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            2.457749843597412)),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(white)),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(
                                                false); // dismisses only the dialog and returns false
                                      },
                                      child: Text('Cancel',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: dullgreen,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  ),
                                  Container(
                                    width: 80.15,
                                    height: 39,
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            2.457749843597412)),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  dullgreen)),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(
                                                true); // dismisses only the dialog and returns true
                                      },
                                      child: Text('Log out'),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  if (result) context.read<FirebaseAuthentication>().signOut();
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
