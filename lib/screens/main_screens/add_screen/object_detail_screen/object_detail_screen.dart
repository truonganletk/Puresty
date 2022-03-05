import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puresty/models/fruit.dart';

class ObjectDetail extends StatefulWidget {
  final Fruit fr;
  const ObjectDetail({Key? key, required this.fr}) : super(key: key);
  @override
  State<ObjectDetail> createState() => _ObjectDetailState();
}

class _ObjectDetailState extends State<ObjectDetail> {
  final TextEditingController foodweightcontroller = TextEditingController();
  String errorMessage = '';
  Fruit fr = Fruit.empty();

  _addfood(String fweight) {
    CollectionReference foodeaten = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('foodeaten');
    print(FirebaseAuth.instance.currentUser?.uid);
    foodeaten
        .add({
          'date': Timestamp.now(),
          'foodid': fr.id,
          'foodweight': int.parse(fweight),
        })
        .then((value) => print("Foodeaten Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void initState() {
    super.initState();
    fr = widget.fr;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Text(
                'Back',
                style: TextStyle(fontSize: 50),
              ),
            ),
          ),
          Text(fr.name),
          Text(fr.cal.toString()),
          Text(fr.carbs.toString()),
          Text(fr.fats.toString()),
          Text(fr.protein.toString()),
          Text(fr.fibre.toString()),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text('Your serving size'),
            ],
          ),
          Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: TextField(
                    controller: foodweightcontroller,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: 'eg. 250g',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      _addfood(foodweightcontroller.text);
                    },
                    child: Text('Add'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
