import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/constants/size_config.dart';
import 'package:puresty/screens/auth_screens/sign_up_screen/sign_up_screen.dart';
import 'package:puresty/services/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(2.64 * SizeConfig.heightMultiplier),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: SvgPicture.asset('assets/logo/PurestyLogo.svg')),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: darkgreyblue,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dont have an account ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: darkgreyblue,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()),
                              )
                            },
                            child: Text(
                              'Sign up',
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
                          'Email',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
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
                          contentPadding: EdgeInsets.all(15),
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
                          'Password',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
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
                          contentPadding: EdgeInsets.all(15),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: darkgreyblue,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 100 * SizeConfig.widthMultiplier,
                      height: 5.93 * SizeConfig.heightMultiplier,
                      margin: EdgeInsets.only(top: 20, bottom: 15),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(7)),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(dullgreen)),
                          onPressed: () {
                            context.read<FirebaseAuthentication>().signIn(
                                emailController.text, passwordController.text);
                          },
                          child: Container(
                              child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: white,
                            ),
                          ))),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: black,
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: darkgreyblue,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: black)),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(7)),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(white)),
                          onPressed: () {
                            context
                                .read<FirebaseAuthentication>()
                                .signInWithGoogle();
                          },
                          child: Container(
                              padding: EdgeInsets.all(15),
                              width: 100 * SizeConfig.widthMultiplier,
                              height: 5.93 * SizeConfig.heightMultiplier,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child:
                                        Icon(Icons.face, color: darkgreyblue),
                                  ),
                                  Text(
                                    "Login with Google",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: darkgreyblue,
                                    ),
                                  ),
                                ],
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(7)),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(white)),
                          onPressed: () {
                            context
                                .read<FirebaseAuthentication>()
                                .signInAnonymous();
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              width: 100 * SizeConfig.widthMultiplier,
                              height: 5.93 * SizeConfig.heightMultiplier,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Use Puresty as a guest",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: darkgreyblue,
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
