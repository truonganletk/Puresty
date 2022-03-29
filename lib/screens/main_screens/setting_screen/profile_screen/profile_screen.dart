import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/constants/size_config.dart';
import 'package:puresty/services/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

enum Sex { female, male }

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getInfo();
  }

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

  void getInfo() {
    FirebaseAuthentication.getUserInfo().then((value) {
      setState(() {
        height = value.height.toString();
        weight = value.weight.toString();
        fullname = value.fullname;
        emailController.text = value.email;
        fullnameController.text = value.fullname;
        usernameController.text = value.username;
        weightController.text = value.weight.toString();
        heightController.text = value.height.toString();
        if (value.sex.toLowerCase() == "sex.female")
          _sex = Sex.female;
        else
          _sex = Sex.male;
      });
    });
  }

  Future<bool> checkInfo() async {
    bool temp = true;
    await FirebaseAuthentication.getUserInfo().then((value) {
      //print(fullnameController.text);
      //print(value.fullname == fullnameController.text);
      if (fullnameController.text == value.fullname &&
          weightController.text == value.weight.toString() &&
          heightController.text == value.height.toString() &&
          value.sex.toLowerCase() == _sex.toString().toLowerCase())
        temp = false;
      print('1' + temp.toString());
    });
    print('2' + temp.toString());
    return temp;
  }

  updateinfo() async {
    await checkInfo().then((value) {
      if (!value) {
        _showToast("Nothing changes!");
        return;
      }
      if (fullnameController.text == '' ||
          weightController.text == '' ||
          heightController.text == '') {
        _showToast("This information need to be filled.");
        return;
      } else if (!isNumeric(weightController.text)) {
        _showToast("Weight has to be a number!");
        return;
      } else if (!isNumeric(heightController.text)) {
        _showToast("Height has to be a number!");
        return;
      } else if (fullnameController.text.length > 26) {
        _showToast("Full name must be less than 26 characters.");
        return;
      } else if (weightController.text.length < 2 ||
          weightController.text.length > 3) {
        _showToast("Your weight is invalid.");
        return;
      } else if (heightController.text.length < 2 ||
          heightController.text.length > 3) {
        _showToast("Your height is invalid.");
        return;
      }
      FirebaseAuthentication.updateInfo(fullnameController.text,
          _sex.toString(), heightController.text, weightController.text);
      setState(() {
        height = heightController.text;
        weight = weightController.text;
        fullname = fullnameController.text;
      });
    });
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Sex? _sex = Sex.female;
  String height = "0";
  String weight = "0";
  String fullname = "";
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return Scaffold(
          body: Container(
            padding: EdgeInsets.fromLTRB(
                2.64 * SizeConfig.heightMultiplier,
                4.64 * SizeConfig.heightMultiplier,
                2.64 * SizeConfig.heightMultiplier,
                2.64 * SizeConfig.heightMultiplier),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: GestureDetector(
                              onTap: () => {Navigator.pop(context)},
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    size: 30,
                                  ),
                                  Text("Your profile",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      ))
                                ],
                              )),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: 150,
                        height: 150,
                        child: Image.asset('assets/images/avatar.png')),
                    Text(
                      fullname.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: darkgreyblue,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
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
                                  weight.toString() + "Kg",
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
                                  height.toString() + "cm",
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
                      margin: EdgeInsets.only(top: 10, bottom: 15),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(children: [
                          Radio<Sex>(
                            value: Sex.female,
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
                              value: Sex.male,
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
                                margin: EdgeInsets.only(top: 10, bottom: 15),
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
                                margin: EdgeInsets.only(top: 10, bottom: 15),
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
                      margin: EdgeInsets.only(top: 10, bottom: 15),
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
                      margin: EdgeInsets.only(top: 10, bottom: 15),
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
                      margin: EdgeInsets.only(top: 10, bottom: 15),
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
                      margin: EdgeInsets.only(top: 15),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(7)),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(dullgreen)),
                          onPressed: () {
                            updateinfo();
                          },
                          child: Container(
                              width: 100 * SizeConfig.widthMultiplier,
                              height: 5.93 * SizeConfig.heightMultiplier,
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
          ),
        );
      });
    });
  }
}
