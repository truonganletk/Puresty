import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth;

  FirebaseAuthentication(this._auth);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future signIn(String user, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password);
      print('login successful');
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
