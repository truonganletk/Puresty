import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/constants/size_config.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return Scaffold(
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 76.33 * SizeConfig.widthMultiplier,
                    height: 56.89 * SizeConfig.heightMultiplier,
                    child: SvgPicture.asset(
                        'assets/images/undraw_my_personal_files_re_3q0p.svg')),
                Container(
                  height: 6.40 * SizeConfig.heightMultiplier,
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
                    height: 8.40 * SizeConfig.heightMultiplier,
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
                  width: 76.33 * SizeConfig.widthMultiplier,
                  height: 6.40 * SizeConfig.heightMultiplier,
                  decoration: new BoxDecoration(
                      color: dullgreen,
                      borderRadius: BorderRadius.circular(5.75)),
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
      });
    });
  }
}
