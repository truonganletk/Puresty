import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puresty/services/firebase_auth.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                context.read<FirebaseAuthentication>().signOut();
              },
              child: Text("What you ate")),
          ElevatedButton(
              onPressed: () {
                context.read<FirebaseAuthentication>().signOut();
              },
              child: Text("You profile")),
          ElevatedButton(
              onPressed: () {
                context.read<FirebaseAuthentication>().signOut();
              },
              child: Text("Log out")),
        ],
      ),
    );
  }
}
