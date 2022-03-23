import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/models/foodcart.dart';
import 'package:puresty/services/firebase_auth.dart';

enum StateView { Daily, Monthly }
final now = new DateTime.now();

class ReportScreen extends StatefulWidget {
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  List<String> listOfDays = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
  ];

  int currentDay = now.day;
  int currentYear = now.year;
  int currentMonth = now.month;
  StateView _stateView = StateView.Daily;
  String errorMessage = '';
  bool isFetching = false;
  bool hasNext = true;
  bool gotdata = false;
  bool hasPrevTime = false;
  int prevCal = 0;
  int prevFats = 0;
  int prevCarbs = 0;
  int prevProtein = 0;
  int prevFibre = 0;
  List _allresultList = [];
  List _listfoodcartitem = [];
  double totalCal = 0.0;
  double totalFats = 0.0;
  double totalCarbs = 0.0;
  double totalProtein = 0.0;
  double totalFibre = 0.0;
  int totalItems = 0;
  double totalWeight = 0.0;
  bool? isAnony = FirebaseAuth.instance.currentUser?.isAnonymous;

  @override
  void initState() {
    super.initState();
    getfoodcart();
  }

  @override
  void dispose() {
    super.dispose();
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
          .orderBy('date', descending: true);
      var data = await fcart.get();
      setState(() {
        gotdata = true;
        _allresultList.addAll(data.docs);
        for (DocumentSnapshot snapshot in data.docs) {
          _listfoodcartitem.add(FoodCartItem.fromSnapshot(snapshot));
          //print(FoodCartItem.fromSnapshot(snapshot).date.toDate());
        }
      });
      print('get foodcart successful');
      _refreshdata();
    } catch (error) {
      errorMessage = error.toString();
    }
    isFetching = false;
  }

  void _refreshdata() {
    double tempCal = 0.0;
    double tempFats = 0.0;
    double tempCarbs = 0.0;
    double tempProtein = 0.0;
    double tempFibre = 0.0;
    double tempPrevCal = 0.0;
    double tempPrevFats = 0.0;
    double tempPrevCarbs = 0.0;
    double tempPrevProtein = 0.0;
    double tempPrevFibre = 0.0;
    int tempItems = 0;
    double tempWeight = 0.0;
    bool temphasPrevTime = false;
    for (FoodCartItem item in _listfoodcartitem) {
      DateTime itemTime = item.date.toDate();
      DateTime prevDay = DateTime(currentYear, currentMonth, currentDay - 1);
      DateTime prevMonth = DateTime(currentYear, currentMonth - 1);
      if ((_stateView == StateView.Daily &&
              itemTime.year == currentYear &&
              itemTime.month == currentMonth &&
              itemTime.day == currentDay) ||
          (_stateView == StateView.Monthly &&
              itemTime.year == currentYear &&
              itemTime.month == currentMonth)) {
        tempCal += double.parse(item.cal.toString()) *
            double.parse(item.foodweight.toString());
        tempFats += double.parse(item.fats.toString()) *
            double.parse(item.foodweight.toString());
        tempCarbs += double.parse(item.carbs.toString()) *
            double.parse(item.foodweight.toString());
        tempProtein += double.parse(item.protein.toString()) *
            double.parse(item.foodweight.toString());
        tempFibre += double.parse(item.fibre.toString()) *
            double.parse(item.foodweight.toString());
        tempItems++;
        tempWeight += double.parse(item.foodweight.toString());
      }
      if ((_stateView == StateView.Daily &&
              itemTime.year == prevDay.year &&
              itemTime.month == prevDay.month &&
              itemTime.day == prevDay.day) ||
          (_stateView == StateView.Monthly &&
              itemTime.year == prevMonth.year &&
              itemTime.month == prevMonth.month)) {
        temphasPrevTime = true;
        tempPrevCal += double.parse(item.cal.toString()) *
            double.parse(item.foodweight.toString());
        tempPrevFats += double.parse(item.fats.toString()) *
            double.parse(item.foodweight.toString());
        tempPrevCarbs += double.parse(item.carbs.toString()) *
            double.parse(item.foodweight.toString());
        tempPrevProtein += double.parse(item.protein.toString()) *
            double.parse(item.foodweight.toString());
        tempPrevFibre += double.parse(item.fibre.toString()) *
            double.parse(item.foodweight.toString());
      }
    }
    setState(() {
      totalCal = tempCal / 100;
      totalFats = tempFats / 100;
      totalCarbs = tempCarbs / 100;
      totalProtein = tempProtein / 100;
      totalFibre = tempFibre / 100;
      totalItems = tempItems;
      totalWeight = tempWeight / 100;
      hasPrevTime = temphasPrevTime;
      prevCal = totalCal.compareTo(tempPrevCal);
      prevFats = totalFats.compareTo(tempPrevFats);
      prevCarbs = totalCarbs.compareTo(tempPrevCarbs);
      prevProtein = totalProtein.compareTo(tempPrevProtein);
      prevFibre = totalFibre.compareTo(tempPrevFibre);
    });
  }

  void _previousDay() {
    setState(() {
      if (currentDay == 1) {
        currentDay = (currentMonth > 1)
            ? new DateTime(currentYear, currentMonth, 0).day
            : new DateTime(currentYear - 1, 1, 0).day;
        if (currentMonth == 1) {
          currentMonth = 12;
          currentYear--;
        } else {
          currentMonth--;
        }
      } else {
        currentDay--;
      }
    });
    _refreshdata();
  }

  void _nextDay() {
    setState(() {
      int lastDayDateTime = (currentMonth < 12)
          ? new DateTime(currentYear, currentMonth + 1, 0).day
          : new DateTime(currentYear + 1, 1, 0).day;
      if (currentDay == lastDayDateTime) {
        currentDay = 1;
        if (currentMonth == 12) {
          currentMonth = 1;
          currentYear++;
        } else {
          currentMonth++;
        }
      } else {
        currentDay++;
      }
    });
    _refreshdata();
  }

  void _previousMonth() {
    setState(() {
      if (currentMonth == 1) {
        currentMonth = 12;
        currentYear--;
      } else {
        currentMonth--;
      }
    });
    _refreshdata();
  }

  void _nextMonth() {
    setState(() {
      if (currentMonth == 12) {
        currentMonth = 1;
        currentYear++;
      } else {
        currentMonth++;
      }
    });
    _refreshdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Text(
                    'Report',
                    style: TextStyle(
                      color: black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                  'How it goes? This is a report on the nutrition you got into the body based on what you ate.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: darkgreyblue,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  )),
            ),
            !isAnony!
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 90.15,
                              height: 39,
                              decoration: new BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(2.457749843597412)),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: _stateView ==
                                            StateView.Daily
                                        ? MaterialStateProperty.all(dullgreen)
                                        : MaterialStateProperty.all(white)),
                                onPressed: () {
                                  setState(() {
                                    _stateView = StateView.Daily;
                                    currentDay = now.day;
                                    currentYear = now.year;
                                    currentMonth = now.month;
                                    _refreshdata();
                                  });
                                },
                                child: Text('Daily',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: _stateView == StateView.Daily
                                          ? white
                                          : dullgreen,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ),
                            ),
                            Container(
                              width: 90.15,
                              height: 39,
                              decoration: new BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(2.457749843597412)),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: _stateView ==
                                            StateView.Monthly
                                        ? MaterialStateProperty.all(dullgreen)
                                        : MaterialStateProperty.all(white)),
                                onPressed: () {
                                  setState(() {
                                    _stateView = StateView.Monthly;
                                    currentDay = now.day;
                                    currentYear = now.year;
                                    currentMonth = now.month;
                                    _refreshdata();
                                  });
                                },
                                child: Text('Monthly',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: _stateView == StateView.Monthly
                                          ? white
                                          : dullgreen,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      gotdata
                          ? Container(
                              height: 300,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Divider(
                                        color: black,
                                      )),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Text('Total'),
                                              ],
                                            ),
                                            SizedBox(width: 55),
                                            Column(
                                              children: [
                                                Text(totalItems.toString() +
                                                    ' items'),
                                              ],
                                            ),
                                            SizedBox(width: 55),
                                            Column(
                                              children: [
                                                Text(totalWeight
                                                        .toStringAsFixed(2) +
                                                    ' g'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 7),
                                                    padding: EdgeInsets.all(5),
                                                    child: Text('Cal')),
                                                Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 7),
                                                    padding: EdgeInsets.all(5),
                                                    child: Text('Fats')),
                                                Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 7),
                                                    padding: EdgeInsets.all(5),
                                                    child: Text('Carbs')),
                                                Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 7),
                                                    padding: EdgeInsets.all(5),
                                                    child: Text('Protein')),
                                                Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 7),
                                                    padding: EdgeInsets.all(5),
                                                    child: Text('Fibre')),
                                              ],
                                            ),
                                            SizedBox(width: 55),
                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 7),
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(totalCal
                                                          .toStringAsFixed(2) +
                                                      ' kCal'),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 7),
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(totalFats
                                                          .toStringAsFixed(2) +
                                                      ' g'),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 7),
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(totalCarbs
                                                          .toStringAsFixed(2) +
                                                      ' g'),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 7),
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(totalProtein
                                                          .toStringAsFixed(2) +
                                                      ' g'),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 7),
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(totalFibre
                                                          .toStringAsFixed(2) +
                                                      ' g'),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 7),
                                                  padding: EdgeInsets.all(5),
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        (totalCal >= 630 &&
                                                                totalCal <= 700)
                                                            ? softgreen
                                                            : (totalCal > 700
                                                                ? pastelred
                                                                : dustyorange),
                                                    child: Icon(
                                                      (prevCal == 0)
                                                          ? Icons
                                                              .horizontal_rule
                                                          : (prevCal == 1)
                                                              ? Icons
                                                                  .keyboard_arrow_up
                                                              : Icons
                                                                  .keyboard_arrow_down,
                                                      size: 15,
                                                      color: white,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 7),
                                                  padding: EdgeInsets.all(3),
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        (totalFats >= 630 &&
                                                                totalFats <=
                                                                    700)
                                                            ? softgreen
                                                            : (totalFats > 700
                                                                ? pastelred
                                                                : dustyorange),
                                                    child: Icon(
                                                      (prevFats == 0)
                                                          ? Icons
                                                              .horizontal_rule
                                                          : (prevFats == 1)
                                                              ? Icons
                                                                  .keyboard_arrow_up
                                                              : Icons
                                                                  .keyboard_arrow_down,
                                                      size: 15,
                                                      color: white,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 7),
                                                  padding: EdgeInsets.all(3),
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        (totalCarbs >= 630 &&
                                                                totalCarbs <=
                                                                    700)
                                                            ? softgreen
                                                            : (totalCarbs > 700
                                                                ? pastelred
                                                                : dustyorange),
                                                    child: Icon(
                                                      (prevCarbs == 0)
                                                          ? Icons
                                                              .horizontal_rule
                                                          : (prevCarbs == 1)
                                                              ? Icons
                                                                  .keyboard_arrow_up
                                                              : Icons
                                                                  .keyboard_arrow_down,
                                                      size: 15,
                                                      color: white,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 7),
                                                  padding: EdgeInsets.all(3),
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        (totalProtein >= 630 &&
                                                                totalProtein <=
                                                                    700)
                                                            ? softgreen
                                                            : (totalProtein >
                                                                    700
                                                                ? pastelred
                                                                : dustyorange),
                                                    child: Icon(
                                                      (prevProtein == 0)
                                                          ? Icons
                                                              .horizontal_rule
                                                          : (prevProtein == 1)
                                                              ? Icons
                                                                  .keyboard_arrow_up
                                                              : Icons
                                                                  .keyboard_arrow_down,
                                                      size: 15,
                                                      color: white,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 7),
                                                  padding: EdgeInsets.all(3),
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        (totalFibre >= 630 &&
                                                                totalFibre <=
                                                                    700)
                                                            ? softgreen
                                                            : (totalFibre > 700
                                                                ? pastelred
                                                                : dustyorange),
                                                    child: Icon(
                                                      (prevFibre == 0)
                                                          ? Icons
                                                              .horizontal_rule
                                                          : (prevFibre == 1)
                                                              ? Icons
                                                                  .keyboard_arrow_up
                                                              : Icons
                                                                  .keyboard_arrow_down,
                                                      size: 15,
                                                      color: white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
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
                                ],
                              ),
                            )
                          : Container(
                              height: 300,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: CircularProgressIndicator(
                                      color: dullgreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              _stateView == StateView.Daily
                                  ? _previousDay()
                                  : _previousMonth();
                            },
                            icon: Icon(
                              Icons.arrow_left,
                              color: darkgreyblue,
                              size: 40,
                            ),
                          ),
                          Text(
                            listOfMonths[currentMonth - 1] +
                                (_stateView == StateView.Daily
                                    ? ' ' + listOfDays[currentDay - 1] + ', '
                                    : ' ') +
                                currentYear.toString(),
                            style: TextStyle(
                              color: darkgreyblue,
                              fontSize: 24,
                              fontFamily: 'SegoeUI',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _stateView == StateView.Daily
                                  ? _nextDay()
                                  : _nextMonth();
                            },
                            icon: Icon(
                              Icons.arrow_right,
                              color: darkgreyblue,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(
                    width: 80.15,
                    height: 39,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(2.457749843597412)),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(dullgreen)),
                      onPressed: () {
                        context.read<FirebaseAuthentication>().signOut();
                      },
                      child: Text('Sign In'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
