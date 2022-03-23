import 'package:cloud_firestore/cloud_firestore.dart';

class Notif {
  dynamic datecreate;
  String title;
  String content;
  String navigation;

  Notif(this.datecreate, this.title, this.content, this.navigation);

  Notif.empty()
      : title = "",
        content = "",
        navigation = "";

  Notif.fromSnapshot(DocumentSnapshot snapshot)
      : datecreate = snapshot.get('datecreate'),
        title = snapshot.get('title'),
        content = snapshot.get('content'),
        navigation = snapshot.get('navigation');
}
