import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:puresty/constants/app_colors.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
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
                      leading: Radio<Sex>(
                        value: Sex.Female,
                        groupValue: _sex,
                        onChanged: (Sex? value) {
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
                      ),
                      leading: Radio<Sex>(
                        value: Sex.Male,
                        groupValue: _sex,
                        onChanged: (Sex? value) {
                          setState(() {
                            _sex = value;
                          });
                        },
                      ),
                    ),
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
                    hintText: 'Enter your Password',
                  ),
                  obscureText: !showPassword,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(7)),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(dullgreen)),
                    onPressed: () {
                      if (fullnameController.text == '' ||
                          weightController.text == '' ||
                          heightController.text == '' ||
                          emailController.text == '' ||
                          usernameController.text == '' ||
                          passwordController.text == '') {
                        _showToast("Chưa nhập đủ thông tin");
                      } else if (!emailController.text.contains('@')) {
                        _showToast("Cần nhập đúng email");
                      } else if (!isNumeric(weightController.text)) {
                        _showToast("Weight là 1 số");
                      } else if (!isNumeric(heightController.text)) {
                        _showToast("Height là 1 số");
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
                        padding: EdgeInsets.all(10),
                        width: 395,
                        height: 45,
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
  }
}
