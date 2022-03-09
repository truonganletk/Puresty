import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:puresty/constants/app_colors.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: softgreen,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/logo/PurestyLogo2.svg'),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(top: 20),
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: white,
                  )),
            ],
          ),
        ));
  }
}
