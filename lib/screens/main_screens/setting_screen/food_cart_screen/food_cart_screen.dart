import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/constants/size_config.dart';
import 'package:puresty/models/foodcart.dart';

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
  bool gotdata = false;
  int documentLimit = 5;
  List _allresultList = [];
  List _listfoodcartitem = [];

  String convertToDayAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dateToCheck = DateTime(input.year, input.month, input.day);
    if (dateToCheck == today) {
      return 'Today';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday';
    } else
      return '${diff.inDays} days ago';
  }

  bool compareDate(DateTime input1, DateTime input2) {
    final date1 = DateTime(input1.year, input1.month, input1.day);
    final date2 = DateTime(input2.year, input2.month, input2.day);
    if (date1 == date2) {
      return true;
    } else
      return false;
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      //print("scrollend");
      //print(hasNext);
      if (hasNext) {
        getfoodcart();
      }
    }
  }

  getfoodcart() async {
    if (isFetching) return;
    print('get food cart');
    errorMessage = '';
    isFetching = true;
    try {
      var fcart = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('foodeaten')
          .orderBy('date', descending: true)
          .limit(documentLimit);
      final startAfter = _allresultList.isNotEmpty ? _allresultList.last : null;
      var data;
      if (startAfter == null) {
        data = await fcart.get();
      } else {
        data = await fcart.startAfterDocument(startAfter).get();
      }

      setState(() {
        gotdata = true;
        _allresultList.addAll(data.docs);
        //print('get _allresultList successful');
        for (DocumentSnapshot snapshot in data.docs) {
          _listfoodcartitem.add(FoodCartItem.fromSnapshot(snapshot));
          //print(FoodCartItem.fromSnapshot(Snapshot).foodname);
        }
      });
      if (data.docs.length < documentLimit)
        setState(() {
          hasNext = false;
        });
      print('get foodcart successful');
      //print(data.docs.length);
    } catch (error) {
      errorMessage = error.toString();
    }
    isFetching = false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return Scaffold(
          body: Container(
            padding: EdgeInsets.fromLTRB(
                2.64 * SizeConfig.heightMultiplier,
                4.64 * SizeConfig.heightMultiplier,
                2.64 * SizeConfig.heightMultiplier,
                2.64 * SizeConfig.heightMultiplier),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                          onTap: () => {Navigator.pop(context)},
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                              ),
                              Text("What you ate",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ))
                            ],
                          )),
                    ),
                  ],
                ),
                _allresultList.length != 0 && gotdata
                    ? SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                width: 127.55 * SizeConfig.widthMultiplier,
                                child: Column(
                                  children: [
                                    Container(
                                      width:
                                          127.55 * SizeConfig.widthMultiplier,
                                      height:
                                          79.05 * SizeConfig.heightMultiplier,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(8),
                                          controller: scrollController,
                                          itemCount: _allresultList.length + 1,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (index >=
                                                _allresultList.length) {
                                              if (hasNext) {
                                                return Center(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 15),
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              } else {
                                                return Center(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 15),
                                                    child: Text(
                                                      'No more Result',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                );
                                              }
                                            } else
                                              return Column(
                                                children: [
                                                  if (index == 0 ||
                                                      !compareDate(
                                                          _listfoodcartitem
                                                              .elementAt(index)
                                                              .date
                                                              .toDate(),
                                                          _listfoodcartitem
                                                              .elementAt(
                                                                  index - 1)
                                                              .date
                                                              .toDate()))
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child: Divider(
                                                            color: black,
                                                          )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              convertToDayAgo(
                                                                  _listfoodcartitem
                                                                      .elementAt(
                                                                          index)
                                                                      .date
                                                                      .toDate()),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 18,
                                                                color:
                                                                    darkgreyblue,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: Divider(
                                                                  color:
                                                                      black)),
                                                        ],
                                                      ),
                                                    ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 15),
                                                    width: 102.55 *
                                                        SizeConfig
                                                            .widthMultiplier,
                                                    height: 15.15 *
                                                        SizeConfig
                                                            .heightMultiplier,
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x19000000),
                                                          offset: Offset(0, 2),
                                                          blurRadius: 10,
                                                          spreadRadius: 0,
                                                        )
                                                      ],
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          width: 20.61 *
                                                              SizeConfig
                                                                  .widthMultiplier,
                                                          height: 10.15 *
                                                              SizeConfig
                                                                  .heightMultiplier,
                                                          decoration:
                                                              new BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.007169723510742),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: FittedBox(
                                                              child: Image.asset(
                                                                  'assets/images/fruits/' +
                                                                      _listfoodcartitem
                                                                          .elementAt(
                                                                              index)
                                                                          .foodname
                                                                          .replaceAll(
                                                                              ' ',
                                                                              '') +
                                                                      '.jpg',
                                                                  errorBuilder:
                                                                      (context,
                                                                          error,
                                                                          stackTrace) {
                                                                return Image.asset(
                                                                    'assets/images/fruit.jpg');
                                                              }),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 47.19 *
                                                              SizeConfig
                                                                  .widthMultiplier,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                _listfoodcartitem
                                                                    .elementAt(
                                                                        index)
                                                                    .foodname
                                                                    .toUpperCase(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color:
                                                                      darkgreyblue,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      'Your serving size:   '),
                                                                  Text(_listfoodcartitem
                                                                          .elementAt(
                                                                              index)
                                                                          .foodweight
                                                                          .toString() +
                                                                      'g'),
                                                                ],
                                                              ),
                                                              Text(_listfoodcartitem
                                                                      .elementAt(
                                                                          index)
                                                                      .date
                                                                      .toDate()
                                                                      .hour
                                                                      .toString() +
                                                                  ':' +
                                                                  _listfoodcartitem
                                                                      .elementAt(
                                                                          index)
                                                                      .date
                                                                      .toDate()
                                                                      .minute
                                                                      .toString()),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
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
                        height: 79.05 * SizeConfig.heightMultiplier,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            !gotdata
                                ? CircularProgressIndicator(
                                    color: dullgreen,
                                  )
                                : Text('No result'),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        );
      });
    });
  }
}
