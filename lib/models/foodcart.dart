import 'package:cloud_firestore/cloud_firestore.dart';

class FoodCartItem {
  dynamic date;
  dynamic foodid;
  dynamic foodweight;

  FoodCartItem(this.date, this.foodid, this.foodweight);

  FoodCartItem.empty()
      : date = "",
        foodweight = "",
        foodid = "";

  FoodCartItem.fromSnapshot(DocumentSnapshot snapshot)
      : date = snapshot.get('date'),
        foodid = snapshot.get('foodid'),
        foodweight = snapshot.get('foodweight');
}
