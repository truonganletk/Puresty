import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:puresty/constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

enum Gender { female, male }

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Gender? _sex = Gender.female;
  bool showPassword = false;
  int val = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                        onTap: () => {Navigator.pop(context)},
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        )),
                  ),
                ],
              ),
              Container(
                  width: 100,
                  height: 100,
                  child: SvgPicture.asset(
                      'assets/images/undraw_my_personal_files_re_3q0p.svg')),
              Text("Fullname",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: darkgreyblue,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 35.0,
                          child: Center(
                            child: Text(
                              "WEIGHT",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: darkgreyblue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40.0,
                          child: Text(
                            "69Kg",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: darkgreyblue,
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 35.0,
                          child: Center(
                              child: Text(
                            "HEIGHT",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: darkgreyblue,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          )),
                        ),
                        Container(
                          height: 40.0,
                          child: Text(
                            "196cm",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: darkgreyblue,
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                    children: [
                      Text(
                        'Sex',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: darkgreyblue,
                        ),
                      ),
                    ],
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
                  enabled: false,
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
                  enabled: false,
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
                  enabled: false,
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
              Container(
                padding: EdgeInsets.only(top: 15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(7)),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(dullgreen)),
                    onPressed: () {},
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: 395,
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Update",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: white,
                              ),
                            ),
                          ],
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
