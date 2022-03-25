import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/constants/size_config.dart';
import 'package:puresty/models/notification.dart';
import 'package:puresty/services/firebase_auth.dart';

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
  int documentLimit = 10;
  List _allresultList = [];
  List _listnotif = [];
  bool? isAnony = FirebaseAuth.instance.currentUser?.isAnonymous;

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
                !isAnony!
                    ? _allresultList.length != 0 && gotdata
                        ? SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: 139.95 * SizeConfig.widthMultiplier,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 139.95 *
                                              SizeConfig.widthMultiplier,
                                          height: 85.77 *
                                              SizeConfig.heightMultiplier,
                                          child: ListView.builder(
                                              //padding: const EdgeInsets.all(8),
                                              controller: scrollController,
                                              itemCount:
                                                  _allresultList.length + 1,
                                              itemBuilder:
                                                  (BuildContext context,
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
                                                          '',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
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
                                                                  .elementAt(
                                                                      index)
                                                                  .datecreate
                                                                  .toDate(),
                                                              _listnotif
                                                                  .elementAt(
                                                                      index - 1)
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
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                convertToDayAgo(_listnotif
                                                                    .elementAt(
                                                                        index)
                                                                    .datecreate
                                                                    .toDate()),
                                                                style:
                                                                    TextStyle(
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
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 7,
                                                                vertical: 7),
                                                        width: 103.05 *
                                                            SizeConfig
                                                                .widthMultiplier,
                                                        height: 11.38 *
                                                            SizeConfig
                                                                .heightMultiplier,
                                                        decoration:
                                                            new BoxDecoration(
                                                                color: white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                                boxShadow: [
                                                              BoxShadow(
                                                                color: Color(
                                                                    0x19000000),
                                                                offset: Offset(
                                                                    0, 2),
                                                                blurRadius: 10,
                                                                spreadRadius: 0,
                                                              ),
                                                            ]),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          7),
                                                              child: Icon(
                                                                Icons
                                                                    .notifications_active,
                                                                color:
                                                                    dullgreen,
                                                                size: 50,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        _listnotif
                                                                            .elementAt(index)
                                                                            .title,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              black,
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle:
                                                                              FontStyle.normal,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    width: 63.61 *
                                                                        SizeConfig
                                                                            .widthMultiplier,
                                                                    child: Text(
                                                                      _listnotif
                                                                          .elementAt(
                                                                              index)
                                                                          .content,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                      softWrap:
                                                                          true,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color:
                                                                            black,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                        fontStyle:
                                                                            FontStyle.normal,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      convertToTimeAgo(_listnotif
                                                                          .elementAt(
                                                                              index)
                                                                          .datecreate
                                                                          .toDate()),
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color:
                                                                            black,
                                                                        fontSize:
                                                                            9,
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
                            height: 85.77 * SizeConfig.heightMultiplier,
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
                          )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                    'Please login to perform this function.',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: darkgreyblue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ),
                              Container(
                                width: 80.15,
                                height: 39,
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        2.457749843597412)),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(dullgreen)),
                                  onPressed: () {
                                    context
                                        .read<FirebaseAuthentication>()
                                        .signOut();
                                  },
                                  child: Text('Sign In'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      });
    });
  }
}
