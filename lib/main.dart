// @dart=2.9

import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:puresty/authwrapper.dart';
import 'package:puresty/screens/welcome_screen/welcome_screen.dart';
import 'package:puresty/services/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  //FirebaseAppCheck appCheck = FirebaseAppCheck.instance;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // String token = await FirebaseAppCheck.instance.getToken();
  // print("hello " + token);

  // FirebaseAppCheck.instance.onTokenChange.listen((token) {
  //   print("hello" + token);
  // });
  // await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
  await FirebaseAppCheck.instance.activate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      color: Colors.blue,
      home: new Splash(),
    );
  }
}

class AppProvider extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthentication>(
          create: (_) => FirebaseAuthentication(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<FirebaseAuthentication>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider<FirebaseAuthentication>(
          create: (context) => FirebaseAuthentication(FirebaseAuth.instance),
        )
      ],
      child: MaterialApp(
        title: 'Puresty',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (!_seen) {
      await prefs.setBool('seen', true);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return AppProvider();
  }
}
