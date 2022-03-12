import 'package:cloud_firestore/cloud_firestore.dart';

class FoodCartItem {
  dynamic date;
  dynamic foodid;
  dynamic foodweight;
  String foodname;

  FoodCartItem(this.date, this.foodid, this.foodweight, this.foodname);

  FoodCartItem.empty()
      : foodname = "",
        date = "",
        foodweight = "",
        foodid = "";

  FoodCartItem.fromSnapshot(DocumentSnapshot snapshot)
      : date = snapshot.get('date'),
        foodid = snapshot.get('foodid'),
        foodname = snapshot.get('foodname'),
        foodweight = snapshot.get('foodweight');
}
