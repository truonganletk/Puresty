import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Notification",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              width: 305,
              height: 70,
              decoration: new BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.access_time_filled,
                      color: dullgreen,
                      size: 50,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Ten thong bao",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "noi dung thong bao tom gon",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "2m ago",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              width: 305,
              height: 70,
              decoration: new BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.access_time_filled,
                      color: dullgreen,
                      size: 50,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Ten thong bao",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "noi dung thong bao tom gon",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "2m ago",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
