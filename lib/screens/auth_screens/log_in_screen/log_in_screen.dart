import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puresty/services/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Login'),
          Row(
            children: [Text('Dont-have-an-account-Sign-up')],
          ),
          Text('Email'),
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Enter your Email'),
          ),
          Text('Password'),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(hintText: 'Enter your Password'),
          ),
          Row(
            children: [Text('Forgot Password')],
          ),
          ElevatedButton(
              onPressed: () {
                context
                    .read<FirebaseAuthentication>()
                    .signIn(emailController.text, passwordController.text);
              },
              child: Text("Login")),
          Text('OR'),
          ElevatedButton(onPressed: () {}, child: Text("Login with Google")),
        ],
      ),
    );
  }
}
