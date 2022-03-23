import 'package:cloud_firestore/cloud_firestore.dart';

class UserInf {
  String id;
  String email;
  String fullname;
  String sex;
  String username;
  dynamic height;
  dynamic weight;

  UserInf(this.id, this.username, this.email, this.sex, this.fullname,
      this.height, this.weight);

  UserInf.empty()
      : id = "",
        email = "",
        fullname = "",
        sex = "",
        username = "";

  UserInf.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.get('id'),
        email = snapshot.get('email'),
        fullname = snapshot.get('fullname'),
        sex = snapshot.get('sex'),
        username = snapshot.get('username'),
        height = snapshot.get('height'),
        weight = snapshot.get('weight');
}
