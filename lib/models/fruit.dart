import 'package:cloud_firestore/cloud_firestore.dart';

class Fruit {
  String id;
  String name;
  String description;
  dynamic cal;
  dynamic fats;
  dynamic carbs;
  dynamic fibre;
  dynamic protein;

  Fruit(this.id, this.description, this.name, this.cal, this.fats, this.carbs,
      this.fibre, this.protein);

  Fruit.empty()
      : id = "",
        description = "",
        name = "";

  Fruit.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.get('id'),
        description = snapshot.get('description'),
        name = snapshot.get('name'),
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
