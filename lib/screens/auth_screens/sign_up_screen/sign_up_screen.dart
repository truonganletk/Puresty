import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/constants/size_config.dart';
import 'package:puresty/services/firebase_auth.dart';

enum Sex { Female, Male }

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showPassword = false;
  Sex? _sex = Sex.Female;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: pastelred,
      textColor: white,
      gravity: ToastGravity.TOP,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  bool isNumeric(String str) {
    try {
      // ignore: unused_local_variable
      var value = double.parse(str);
    } on FormatException {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  2.64 * SizeConfig.heightMultiplier,
                  4.64 * SizeConfig.heightMultiplier,
                  2.64 * SizeConfig.heightMultiplier,
                  2.64 * SizeConfig.heightMultiplier),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Sign up',
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
                    padding: EdgeInsets.only(top: 10, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: darkgreyblue,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => {Navigator.pop(context)},
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: dullgreen),
                          ),
                        )
                      ],
                    ),
                  ),
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
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 5.93 * SizeConfig.heightMultiplier,
                    margin: EdgeInsets.only(top: 5, bottom: 15),
                    child: TextField(
                      controller: fullnameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                        border: OutlineInputBorder(),
                        counterText: "",
                        hintText: 'Enter your Fullname',
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(children: [
                        Radio<Sex>(
                          value: Sex.Female,
                          groupValue: _sex,
                          onChanged: (Sex? value) {
                            setState(() {
                              _sex = value;
                            });
                          },
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: darkgreyblue,
                          ),
                        ),
                      ]),
                      Row(
                        children: [
                          Radio<Sex>(
                            value: Sex.Male,
                            groupValue: _sex,
                            onChanged: (Sex? value) {
                              setState(() {
                                _sex = value;
                              });
                            },
                          ),
                          Text(
                            'Male',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: darkgreyblue,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              height: 5.93 * SizeConfig.heightMultiplier,
                              width: 45 * SizeConfig.widthMultiplier,
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              child: TextField(
                                controller: weightController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                  border: OutlineInputBorder(),
                                  counterText: "",
                                  hintText: 'Enter your Weight',
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              width: 45 * SizeConfig.widthMultiplier,
                              height: 5.93 * SizeConfig.heightMultiplier,
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              child: TextField(
                                controller: heightController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                  border: OutlineInputBorder(),
                                  counterText: "",
                                  hintText: 'Enter your Height',
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
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 5.93 * SizeConfig.heightMultiplier,
                    margin: EdgeInsets.only(top: 5, bottom: 15),
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
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 5.93 * SizeConfig.heightMultiplier,
                    margin: EdgeInsets.only(top: 5, bottom: 15),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                        border: OutlineInputBorder(),
                        counterText: "",
                        hintText: 'Enter your Username',
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
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 5.93 * SizeConfig.heightMultiplier,
                    margin: EdgeInsets.only(top: 5, bottom: 15),
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
                        hintText: 'Enter your Password',
                      ),
                      obscureText: !showPassword,
                    ),
                  ),
                  Container(
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 5.93 * SizeConfig.heightMultiplier,
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(7)),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(dullgreen)),
                        onPressed: () {
                          if (fullnameController.text == '' ||
                              weightController.text == '' ||
                              heightController.text == '' ||
                              emailController.text == '' ||
                              usernameController.text == '' ||
                              passwordController.text == '') {
                            _showToast("This information need to be filled.");
                          } else if (!emailController.text.contains('@')) {
                            _showToast("Your email address is invalid.");
                          } else if (!isNumeric(weightController.text)) {
                            _showToast("Weight has to be a number!");
                          } else if (!isNumeric(heightController.text)) {
                            _showToast("Height has to be a number!");
                          } else if (usernameController.text.contains(' ')) {
                            _showToast("Username must not contain spaces.");
                          } else if (fullnameController.text.length > 26) {
                            _showToast(
                                "Full name must be less than 26 characters.");
                          } else if (usernameController.text.length < 8 ||
                              usernameController.text.length > 20) {
                            _showToast(
                                "Username must be between 8-20 characters.");
                          } else if (passwordController.text.length < 8 ||
                              passwordController.text.length > 20) {
                            _showToast(
                                "Password must be between 8-20 characters.");
                          } else if (weightController.text.length < 2 ||
                              weightController.text.length > 3) {
                            _showToast("Your weight is invalid.");
                          } else if (heightController.text.length < 2 ||
                              heightController.text.length > 3) {
                            _showToast("Your height is invalid.");
                          } else {
                            context
                                .read<FirebaseAuthentication>()
                                .signUp(
                                    emailController.text,
                                    passwordController.text,
                                    fullnameController.text,
                                    usernameController.text,
                                    _sex.toString(),
                                    heightController.text,
                                    weightController.text)
                                .then((value) =>
                                    {if (value == '') Navigator.pop(context)});
                          }
                        },
                        child: Container(
                            child: Text(
                          "Create account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: white,
                          ),
                        ))),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
