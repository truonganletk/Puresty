import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreNotification {
  Future<void> createNotif(String title, String content, String navigation,
      DateTime datecreate) async {
    var notifications = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notifications');
    await notifications.add({
      'title': title,
      'content': content,
      'navigation': navigation,
      'datecreate': datecreate,
    });
    return;
  }

  // Future<void> deleteUser(String uid) async {
  //   CollectionReference notifications =
  //       FirebaseFirestore.instance.collection('notifications');
  //   await notifications.where('uid', isEqualTo: uid).get().then((value) {
  //     value.docs.forEach((element) {
  //       notifications
  //           .doc(element.id)
  //           .delete()
  //           .then((value) => print("notifications id= " + uid + " Deleted"))
  //           .catchError((error) =>
  //               print("Failed to delete notificationsid= " + uid + ": $error"));
  //     });
  //   });
  // }
}
