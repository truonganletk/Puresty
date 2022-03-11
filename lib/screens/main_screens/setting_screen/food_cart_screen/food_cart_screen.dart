import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/models/foodcart.dart';
import 'package:puresty/models/fruit.dart';

class FoodCart extends StatefulWidget {
  @override
  State<FoodCart> createState() => _FoodCartState();
}

class _FoodCartState extends State<FoodCart> {
  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    getfoodcart();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  final scrollController = ScrollController();
  String errorMessage = '';
  bool isFetching = false;
  bool hasNext = true;
  int documentLimit = 5;
  List _allresultList = [];
  List _listfoodcartitem = [];
  List _fruitlist = [];

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      print("scrollend");
      print(hasNext);
      if (hasNext) {
        getfoodcart();
      }
    }
  }

  frlistadd(String id) async {
    await FirebaseFirestore.instance
        .collection('fruits')
        .doc(id)
        .get()
        .then((value) {
      setState(() {
        _fruitlist.add(Fruit.fromSnapshot(value));
      });
    });
  }

  getfoodcart() async {
    print('get food cart');
    if (isFetching) return;
    errorMessage = '';
    isFetching = true;
    try {
      var fcart = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('foodeaten')
          .limit(documentLimit);
      final startAfter = _allresultList.isNotEmpty ? _allresultList.last : null;
      var data;
      if (startAfter == null) {
        data = await fcart.get();
      } else {
        data = await fcart.startAfterDocument(startAfter).get();
      }
      for (DocumentSnapshot Snapshot in data.docs) {
        await frlistadd(FoodCartItem.fromSnapshot(Snapshot).foodid);
      }
      print('successful');
      setState(() {
        _allresultList.addAll(data.docs);
        for (DocumentSnapshot Snapshot in data.docs) {
          _listfoodcartitem.add(FoodCartItem.fromSnapshot(Snapshot));
        }
      });

      if (data.docs.length < documentLimit)
        setState(() {
          hasNext = false;
        });
      print('get foodcart successful');
    } catch (error) {
      errorMessage = error.toString();
    }
    isFetching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => {Navigator.pop(context)},
                    child: Text(
                      '< What you ate',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: black),
                    ),
                  ),
                ],
              ),
            ),
            _allresultList.length != 0
                ? SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: 500,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 500,
                                  height: 600,
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(8),
                                      controller: scrollController,
                                      itemCount: _allresultList.length + 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index >= _allresultList.length) {
                                          if (hasNext) {
                                            return Center(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 15),
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 15),
                                                child: Text(
                                                  'No more Result',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            );
                                          }
                                        } else
                                          return Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: 302,
                                            height: 101,
                                            decoration: new BoxDecoration(
                                              color: white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x19000000),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 10,
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(5),
                                                  width: 81,
                                                  height: 77,
                                                  decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.007169723510742),
                                                  ),
                                                  child: Image.asset(
                                                      'assets/images/fruit.jpg'),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        _fruitlist
                                                            .elementAt(index)
                                                            .name,
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: darkgreyblue,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              'Your serving size:   '),
                                                          Text('150g'),
                                                        ],
                                                      ),
                                                      Text('9:00'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: dullgreen,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
