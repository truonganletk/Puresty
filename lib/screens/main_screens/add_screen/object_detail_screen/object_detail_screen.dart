import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:puresty/constants/app_colors.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:puresty/main.dart';
import 'package:puresty/models/fruit.dart';
import 'package:puresty/services/firebase_auth.dart';
import 'package:puresty/services/firebase_firestore.dart';

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
  bool? isAnony = FirebaseAuth.instance.currentUser?.isAnonymous;

  bool isNumeric(String str) {
    try {
      // ignore: unused_local_variable
      var value = double.parse(str);
    } on FormatException {
      return false;
    }
    return true;
  }

  void _showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: pastelred,
      textColor: white,
      gravity: ToastGravity.TOP,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  _addfood(String fweight) {
    CollectionReference foodeaten = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('foodeaten');
    //print(FirebaseAuth.instance.currentUser?.uid);
    if (!isNumeric(fweight)) {
      _showToast('Dữ liệu không hợp lệ');
      return;
    }
    foodeaten
        .add({
          'date': Timestamp.now(),
          'foodid': fr.id,
          'foodname': fr.name,
          'cal': fr.cal,
          'carbs': fr.carbs,
          'fats': fr.fats,
          'protein': fr.protein,
          'fibre': fr.fibre,
          'foodweight': int.parse(fweight),
        })
        .then((value) => print("Foodeaten Added"))
        .catchError((error) => print("Failed to add user: $error"));
    FirestoreNotification().createNotif(
      'Add food successfully',
      'Add ' + fr.name + ' to food cart',
      'none',
      DateTime.now(),
    );
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
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: double.infinity,
                child: ClipRRect(
                  child: ShaderMask(
                    shaderCallback: (rect) => LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Color.fromARGB(255, 58, 58, 58),
                        Colors.transparent,
                      ],
                    ).createShader(rect),
                    blendMode: BlendMode.darken,
                    child: Container(
                      height: 229,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            AssetImage('assets/images/posttemplateimage.jpg'),
                        colorFilter:
                            ColorFilter.mode(Colors.black38, BlendMode.darken),
                      )),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
              child: GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: white,
                  )),
            ),
            Positioned(
              top: 200,
              width: MediaQuery.of(context).size.width,
              height: 440,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.0),
                  color: white,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                child: Text(fr.name,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: darkgreyblue,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ))),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Serving size 1 avocado   ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xb2000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text("100g",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: black,
                            )),
                          ],
                        ),
                        Text(
                          "provides a healthy dose of mono-unsaturated fats, which may be helpful in lowering bad cholesterol",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xb2000000),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: black,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Nutritions Per Serving",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: darkgreyblue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                )),
                          ],
                        ),
                        Container(
                          height: 200,
                          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                          child: GridView.count(
                            primary: false,
                            crossAxisCount: 3,
                            crossAxisSpacing: 30,
                            children: <Widget>[
                              Column(
                                children: [
                                  Text(
                                    "Cal",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: darkgreyblue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  Text(fr.cal.toString() + 'kCal',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xb2000000),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Fats",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: darkgreyblue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  Text(fr.fats.toString() + 'g',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xb2000000),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Carbs",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: darkgreyblue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  Text(fr.carbs.toString() + 'g',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xb2000000),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Protein",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: darkgreyblue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  Text(fr.protein.toString() + 'g',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xb2000000),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Fibre",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: darkgreyblue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  Text(fr.fibre.toString() + 'g',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xb2000000),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Your serving size:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xb2000000),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      )),
                ],
              ),
            ),
            Container(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 40,
                    child: TextField(
                      enabled: isAnony! ? false : true,
                      controller: foodweightcontroller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                        counterText: "",
                        hintText: isAnony!
                            ? 'Wanna eat fruits healthier?'
                            : 'eg. 250g',
                      ),
                    ),
                  ),
                  Container(
                    width: 94,
                    height: 40,
                    decoration: new BoxDecoration(
                        color: dullgreen,
                        borderRadius: BorderRadius.circular(3.390000104904175)),
                    margin: EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(dullgreen)),
                        onPressed: () {
                          if (isAnony != null && !isAnony!) {
                            _addfood(foodweightcontroller.text);
                            Navigator.pop(context);
                          } else {
                            context.read<FirebaseAuthentication>().signOut();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AppProvider(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: !isAnony! ? Text('Add') : Text('Sign In')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
