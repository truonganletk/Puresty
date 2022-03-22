import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/models/notification.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    getnotification();
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
  List _listnotif = [];

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

  String convertToTimeAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dateToCheck = DateTime(input.year, input.month, input.day);
    if (dateToCheck == today) {
      final timeToCheck = DateTime(input.hour);
      final currentTime = DateTime(now.hour);
      if (timeToCheck == currentTime) {
        return '${diff.inMinutes}m ago';
      } else {
        return '${diff.inHours}h ago';
      }
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
        getnotification();
      }
    }
  }

  getnotification() async {
    if (isFetching) return;
    print('get notifications');
    errorMessage = '';
    isFetching = true;
    try {
      var fcart = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('notifications')
          .orderBy('datecreate', descending: true)
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
        for (DocumentSnapshot snapShot in data.docs) {
          _listnotif.add(Notif.fromSnapshot(snapShot));
          //print(FoodCartItem.fromSnapshot(Snapshot).foodname);
        }
      });
      if (data.docs.length < documentLimit)
        setState(() {
          hasNext = false;
        });
      print('get notifications successful');
      //print(data.docs.length);
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
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Notification",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            _allresultList.length != 0 && gotdata
                ? SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: 550,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 550,
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
                                                  '',
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
                                                      _listnotif
                                                          .elementAt(index)
                                                          .datecreate
                                                          .toDate(),
                                                      _listnotif
                                                          .elementAt(index - 1)
                                                          .datecreate
                                                          .toDate()))
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Divider(
                                                      color: black,
                                                    )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        convertToDayAgo(
                                                            _listnotif
                                                                .elementAt(
                                                                    index)
                                                                .datecreate
                                                                .toDate()),
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                          color: darkgreyblue,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Divider(
                                                            color: black)),
                                                  ],
                                                ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 7),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                                width: 405,
                                                height: 70,
                                                decoration: new BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Icon(
                                                        Icons
                                                            .notifications_active,
                                                        color: dullgreen,
                                                        size: 50,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                _listnotif
                                                                    .elementAt(
                                                                        index)
                                                                    .title,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: black,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                _listnotif
                                                                    .elementAt(
                                                                        index)
                                                                    .content,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: black,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Text(
                                                        convertToTimeAgo(
                                                            _listnotif
                                                                .elementAt(
                                                                    index)
                                                                .datecreate
                                                                .toDate()),
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: black,
                                                          fontSize: 9,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                        ),
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
                    height: 600,
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
  }
}
