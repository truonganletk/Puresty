import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puresty/services/firebase_auth.dart';

enum Sex { Female, Male }

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Sex? _sex = Sex.Female;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Sign up'),
          Row(
            children: [
              Text('Already have an account?  '),
              GestureDetector(
                onTap: () => {Navigator.pop(context)},
                child: Text('Log in'),
              )
            ],
          ),
          Text('Fullname'),
          TextField(
            controller: fullnameController,
            decoration: InputDecoration(hintText: 'Enter your Fullname'),
          ),
          Text('Sex'),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text('Female'),
                leading: Radio<Sex>(
                  value: Sex.Female,
                  groupValue: _sex,
                  onChanged: (Sex? value) {
                    setState(() {
                      _sex = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Male'),
                leading: Radio<Sex>(
                  value: Sex.Male,
                  groupValue: _sex,
                  onChanged: (Sex? value) {
                    setState(() {
                      _sex = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Text('Weight'),
          TextField(
            controller: weightController,
            decoration: InputDecoration(hintText: 'Weight'),
          ),
          Text('Height'),
          TextField(
            controller: heightController,
            decoration: InputDecoration(hintText: 'Height'),
          ),
          Text('Email'),
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Enter your Email'),
          ),
          Text('Username'),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(hintText: 'Enter your Username'),
          ),
          Text('Password'),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(hintText: 'Enter your Password'),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<FirebaseAuthentication>().signUp(
                    emailController.text,
                    passwordController.text,
                    fullnameController.text,
                    usernameController.text,
                    _sex.toString(),
                    heightController.text,
                    weightController.text);
                Navigator.pop(context);
              },
              child: Text("Create account")),
        ],
      ),
    );
  }
}
