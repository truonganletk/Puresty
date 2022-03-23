import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/models/foodcart.dart';

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
  List _allresultList = [];
  List _listfoodcartitem = [];
  double totalCal = 0.0;
  double totalFats = 0.0;
  double totalCarbs = 0.0;
  double totalProtein = 0.0;
  double totalFibre = 0.0;
  int totalItems = 0;
  double totalWeight = 0.0;

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
    int tempItems = 0;
    double tempWeight = 0.0;
    for (FoodCartItem item in _listfoodcartitem) {
      DateTime itemTime = item.date.toDate();
      if (_stateView == StateView.Daily &&
          itemTime.year == currentYear &&
          itemTime.month == currentMonth &&
          itemTime.day == currentDay) {
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
      } else if (_stateView == StateView.Monthly &&
          itemTime.year == currentYear &&
          itemTime.month == currentMonth) {
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
    }
    setState(() {
      totalCal = tempCal;
      totalFats = tempFats;
      totalCarbs = tempCarbs;
      totalProtein = tempProtein;
      totalFibre = tempFibre;
      totalItems = tempItems;
      totalWeight = tempWeight;
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
                        borderRadius: BorderRadius.circular(2.457749843597412)),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: _stateView == StateView.Daily
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
                        borderRadius: BorderRadius.circular(2.457749843597412)),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: _stateView == StateView.Monthly
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
                    height: 250,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text('Total'),
                                    ],
                                  ),
                                  SizedBox(width: 55),
                                  Column(
                                    children: [
                                      Text(totalItems.toString() + ' items'),
                                    ],
                                  ),
                                  SizedBox(width: 55),
                                  Column(
                                    children: [
                                      Text(totalWeight.toStringAsFixed(2) +
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text('Cal'),
                                      SizedBox(height: 15),
                                      Text('Fats'),
                                      SizedBox(height: 15),
                                      Text('Carbs'),
                                      SizedBox(height: 15),
                                      Text('Protein'),
                                      SizedBox(height: 15),
                                      Text('Fibre'),
                                    ],
                                  ),
                                  SizedBox(width: 55),
                                  Column(
                                    children: [
                                      Text(totalCal.toStringAsFixed(2) +
                                          ' kCal'),
                                      SizedBox(height: 15),
                                      Text(totalFats.toStringAsFixed(2) + ' g'),
                                      SizedBox(height: 15),
                                      Text(
                                          totalCarbs.toStringAsFixed(2) + ' g'),
                                      SizedBox(height: 15),
                                      Text(totalProtein.toStringAsFixed(2) +
                                          ' g'),
                                      SizedBox(height: 15),
                                      Text(
                                          totalFibre.toStringAsFixed(2) + ' g'),
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
                    height: 250,
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
                    _stateView == StateView.Daily ? _nextDay() : _nextMonth();
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
        ),
      ),
    );
  }
}
