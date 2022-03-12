import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:puresty/screens/auth_screens/loading_screen.dart';
import 'package:puresty/screens/auth_screens/log_in_screen/log_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:puresty/screens/main_screens/main_screen.dart';
import 'package:puresty/screens/welcome_screen/welcome_screen.dart';
import 'package:puresty/services/firebase_auth.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    final firebaseUser = context.watch<User?>();
    final provider = Provider.of<FirebaseAuthentication>(context);
    //print(provider.isSigningIn);
    if (provider.isSigningIn) return LoadingScreen();
    print(firebaseUser);
    if (firebaseUser == null) return LoginScreen();
    return MainScreen();
  }
}
