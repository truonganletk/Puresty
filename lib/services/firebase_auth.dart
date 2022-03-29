import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/models/user.dart';
import 'package:puresty/services/firebase_firestore.dart';

class FirebaseAuthentication extends ChangeNotifier {
  final FirebaseAuth _auth;
  bool _isSigningIn = false;

  FirebaseAuthentication(this._auth);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  static Future<UserInf> getUserInfo() async {
    UserInf userInf = UserInf.empty();
    var users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    await users.get().then((value) {
      userInf = UserInf.fromSnapshot(value);
    });
    return userInf;
  }

  static void updateInfo(
      String fullname, String sex, String height, String weight) async {
    var users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    await users
        .update({
          'fullname': fullname,
          'sex': sex,
          'height': int.parse(height),
          'weight': int.parse(weight),
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to add user: $error"));
    FirestoreNotification().createNotif(
      'Profile updated!',
      'Profile update successful',
      'none',
      DateTime.now(),
    );
  }

  Future<String> signUp(String email, String password, String fullname,
      String username, String sex, String height, String weight) async {
    isSigningIn = true;
    String err = '';
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //----------
      var users = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid);
      users
          .set({
            'id': FirebaseAuth.instance.currentUser?.uid,
            'fullname': fullname,
            'username': username,
            'age': 100,
            'email': email,
            'sex': sex,
            'height': int.parse(height),
            'weight': int.parse(weight),
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      //-------------
      isSigningIn = false;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.code,
        backgroundColor: pastelred,
        textColor: white,
        gravity: ToastGravity.TOP,
      );
      err = e.toString();
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      err = e.toString();
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: pastelred,
        textColor: white,
        gravity: ToastGravity.TOP,
      );
    }
    isSigningIn = false;
    return err;
  }

  Future signInAnonymous() async {
    isSigningIn = true;
    try {
      await FirebaseAuth.instance.signInAnonymously();
      print('signInAnonymously successful');
      isSigningIn = false;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.code,
        backgroundColor: pastelred,
        textColor: white,
        gravity: ToastGravity.TOP,
      );
      print(e);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    isSigningIn = false;
  }

  Future signIn(String user, String password) async {
    isSigningIn = true;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password);
      print('login successful');
      isSigningIn = false;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.code,
        backgroundColor: pastelred,
        textColor: white,
        gravity: ToastGravity.TOP,
      );
      print(e);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    isSigningIn = false;
  }

  Future signInWithGoogle() async {
    isSigningIn = true;
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      isSigningIn = false;
      return;
    } else {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      var userinfo = FirebaseAuth.instance.currentUser;
      var users =
          FirebaseFirestore.instance.collection('users').doc(userinfo?.uid);
      users
          .set({
            'id': userinfo?.uid,
            'fullname': userinfo?.displayName,
            'username': userinfo?.email,
            'age': 100,
            'email': userinfo?.email,
            'sex': null,
            'height': null,
            'weight': null,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      isSigningIn = false;
    }
  }

  Future signOut() async {
    isSigningIn = true;
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    isSigningIn = false;
  }
}
