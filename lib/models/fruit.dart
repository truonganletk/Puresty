import 'package:cloud_firestore/cloud_firestore.dart';

class Fruit {
  String name;
  dynamic cal;
  dynamic fats;
  dynamic carbs;
  dynamic fibre;
  dynamic protein;

  Fruit(this.name, this.cal, this.fats, this.carbs, this.fibre, this.protein);

  Fruit.empty()
      : name = "",
        cal = "",
        fats = "";

  Fruit.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.get('name'),
        cal = snapshot.get('cal'),
        fats = snapshot.get('fats'),
        carbs = snapshot.get('carbs'),
        protein = snapshot.get('protein'),
        fibre = snapshot.get('fibre');

  // void fromSnapshot(DocumentSnapshot snapshot) {
  //   Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //   title = data["title"];
  //   content = data['content'];
  //   id = data['id'];
  // }
}
