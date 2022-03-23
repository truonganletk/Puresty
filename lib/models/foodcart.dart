import 'package:cloud_firestore/cloud_firestore.dart';

class FoodCartItem {
  dynamic date;
  dynamic foodid;
  dynamic foodweight;
  dynamic cal;
  dynamic carbs;
  dynamic fibre;
  dynamic fats;
  dynamic protein;
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
        cal = snapshot.get('cal'),
        carbs = snapshot.get('carbs'),
        fibre = snapshot.get('fibre'),
        protein = snapshot.get('protein'),
        fats = snapshot.get('fats'),
        foodname = snapshot.get('foodname'),
        foodweight = snapshot.get('foodweight');
}
