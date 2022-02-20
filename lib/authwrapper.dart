import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puresty/screens/auth_screens/log_in_screen/log_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:puresty/screens/main_screens/main_screen.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    print(firebaseUser);
    if (firebaseUser != null) return MainScreen();
    return LoginScreen();
  }
}
