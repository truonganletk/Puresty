import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String title;
  String content;
  String id;

  Post(this.id, this.title, this.content);

  Post.empty()
      : id = "",
        content = "",
        title = "";

  void fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    title = data["title"];
    content = data['content'];
    id = data['id'];
  }
}
