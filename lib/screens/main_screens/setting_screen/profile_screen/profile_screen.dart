import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/services/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

enum Gender { female, male}  

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Gender? _sex = Gender.female;  
  bool showPassword = false;
  bool _value = false;
  int val = -1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: Scaffold(
        body: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              child: SvgPicture.asset(
                  'assets/images/undraw_my_personal_files_re_3q0p.svg')),
            Container(
            height: 50.0,
            child: Center(
                child: Text(
                  "Username",
                  style: TextStyle(
                      fontFamily: "SanFrancisco",
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500),
            )),
            ),
            Row(
              children : [
                Container(
                  height : 50.0,
                  width : 100.0,
                ),
              Column( children: [
              Container(
              height: 35.0,
                child: Center(
                    child: Text(
                      "WEIGHT",
                      style: TextStyle(
                          fontFamily: "SanFrancisco",
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    )
                ),
              ),
              Container(
              height: 40.0,
                
                    child: Text(
                      "xx",
                      style: TextStyle(
                          fontFamily: "SanFrancisco",
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300),
                    )
                
              ),
              ],
              ),
              Container(
                  height : 80.0,
                  width : 100.0,
                ),
              Column( children: [
              Container(
              height: 35.0,
                child: Center(
                    child: Text(
                      "HEIGHT",
                      style: TextStyle(
                          fontFamily: "SanFrancisco",
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    )
                ),
              ),
              Container(
              height: 40.0,
                
                    child: Text(
                      "yy",
                      style: TextStyle(
                          fontFamily: "SanFrancisco",
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300),
                    )
              ),
              ],
              ),
              ]
            ),
            Column(
              children: [
                Row(
                children: [
                  Text(
                    'Fullname',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: darkgreyblue,
                    ),
                  ),
                ],
              ),
                Container(
                padding: EdgeInsets.only(top: 5, bottom: 15),
                child: TextField(
                  controller: fullnameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    border: OutlineInputBorder(),
                    counterText: "",
                    hintText: 'Fullname',
                  ),
                ),
              ),
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'Female',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: darkgreyblue,
                        ),
                      ),
                      leading: Radio<Gender>(
                        value: Gender.female,
                        groupValue: _sex,
                        onChanged: (Gender? value) {
                          setState(() {
                            _sex = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'Male',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: darkgreyblue,
                        ),
                      ),
                      leading: Radio<Gender>(
                        value: Gender.male,
                        groupValue: _sex,
                        onChanged: (Gender? value) {
                          setState(() {
                            _sex = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Weight',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: darkgreyblue,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 165,
                          padding: EdgeInsets.only(top: 5, bottom: 15),
                          child: TextField(
                            controller: weightController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                              border: OutlineInputBorder(),
                              counterText: "",
                              hintText: 'xx',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Height',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: darkgreyblue,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 165,
                          padding: EdgeInsets.only(top: 5, bottom: 15),
                          child: TextField(
                            controller: heightController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                              border: OutlineInputBorder(),
                              counterText: "",
                              hintText: 'yy',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Row(
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: darkgreyblue,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 15),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    border: OutlineInputBorder(),
                    counterText: "",
                    hintText: 'Enter your Email',
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Username',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: darkgreyblue,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 15),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    border: OutlineInputBorder(),
                    counterText: "",
                    hintText: 'Username',
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: darkgreyblue,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 15),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    border: OutlineInputBorder(),
                    counterText: "",
                    hintText: '*******',
                  ),
                  obscureText: !showPassword,
                ),
              ),
            FlatButton (
              child: Text("       Udpate        "),
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

