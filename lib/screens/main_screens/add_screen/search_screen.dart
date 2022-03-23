import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/models/fruit.dart';
import 'package:puresty/screens/main_screens/add_screen/object_detail_screen/object_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  final scrollController = ScrollController();
  String errorMessage = '';
  bool isFetching = false;
  bool gotdata = false;
  List _allresultList = [];
  List _resultList = [];
  List _fruitlist = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    getallfruits();
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    print('text changed');
    var showResults = [];
    var fResults = [];

    if (searchController.text != "") {
      for (var snapShot in _allresultList) {
        var fruitname = Fruit.fromSnapshot(snapShot).name.toLowerCase();
        if (fruitname.contains(searchController.text.toLowerCase())) {
          showResults.add(snapShot);
        }
      }
    } else {
      showResults = List.from(_allresultList);
    }

    setState(() {
      _resultList = showResults;
      for (var snapshot in _resultList) {
        fResults.add(Fruit.fromSnapshot(snapshot));
      }
      _fruitlist = fResults;
    });
  }

  getallfruits() async {
    //if (isFetching) return;
    errorMessage = '';
    isFetching = true;
    print('get all fruits');
    try {
      var posts = FirebaseFirestore.instance.collection('fruits');
      var data;
      data = await posts.get();
      setState(() {
        gotdata = true;
        _allresultList.addAll(data.docs);
        _resultList.addAll(data.docs);
        for (var snapshot in _resultList) {
          //print(snapshot.get('name'));
          //print(snapshot.get('id'));
          _fruitlist.add(Fruit.fromSnapshot(snapshot));
        }
      });
      print('get all fruits successful');
    } catch (error) {
      errorMessage = error.toString();
    }
    isFetching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: 220,
                      child: FittedBox(
                          child:
                              Image.asset('assets/logo/PurestyLogoText.png'))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      border: OutlineInputBorder(),
                      counterText: "",
                      hintText: 'eg. Orange',
                    ),
                  ),
                ),
                Container(
                  width: 550,
                  alignment: Alignment.center,
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
                        child: _allresultList.length != 0 && gotdata
                            ? ListView.builder(
                                controller: scrollController,
                                padding: const EdgeInsets.all(8),
                                itemCount: _resultList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ObjectDetail(
                                                fr: _fruitlist
                                                    .elementAt(index))),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 15),
                                      width: 550,
                                      height: 131,
                                      decoration: new BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(15),
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
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            width: 81,
                                            height: 77,
                                            decoration: new BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12.007169723510742),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: FittedBox(
                                                child: Image.asset(
                                                    'assets/images/fruits/' +
                                                        _fruitlist
                                                            .elementAt(index)
                                                            .name
                                                            .replaceAll(
                                                                ' ', '') +
                                                        '.jpg',
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                  return Image.asset(
                                                      'assets/images/fruit.jpg');
                                                }),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  _fruitlist
                                                      .elementAt(index)
                                                      .name
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: darkgreyblue,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 210,
                                                child: Expanded(
                                                  child: Text(
                                                    _fruitlist
                                                        .elementAt(index)
                                                        .description,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: darkgreyblue,
                                                      fontSize: 12,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : Container(
                                height: 600,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    !gotdata
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: dullgreen,
                                            ),
                                          )
                                        : Text('No result'),
                                  ],
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
