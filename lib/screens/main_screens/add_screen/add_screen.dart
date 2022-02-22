import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/screens/main_screens/add_screen/scan_screen.dart';
import 'package:puresty/screens/main_screens/add_screen/search_screen.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanScreen()),
              )
            },
            child: Button("SCAN", Icons.camera),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              )
            },
            child: Button("SEARCH", Icons.search),
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final IconData icon;

  Button(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: darksage,
              size: 40,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: darksage,
                fontSize: 21,
              ),
            )
          ],
        ),
        width: 160,
        height: 151.642,
        decoration: new BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(5.970149993896484),
          boxShadow: [
            BoxShadow(
                color: black,
                offset: Offset(0, 2.3880598545074463),
                blurRadius: 3.940299987792969,
                spreadRadius: -3.582089900970459)
          ],
        ));
  }
}
