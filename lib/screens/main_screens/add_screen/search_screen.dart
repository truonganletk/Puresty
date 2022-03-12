import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/models/fruit.dart';
import 'package:puresty/screens/main_screens/add_screen/object_detail_screen/object_detail_screen.dart';
import 'package:puresty/services/firebase_storage.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  final scrollController = ScrollController();
  String errorMessage = '';
  bool isFetching = false;
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
      for (var Snapshot in _allresultList) {
        var fruitname = Fruit.fromSnapshot(Snapshot).name.toLowerCase();
        if (fruitname.contains(searchController.text.toLowerCase())) {
          showResults.add(Snapshot);
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
    try {
      var posts = FirebaseFirestore.instance.collection('fruits');
      var data;
      data = await posts.get();
      setState(() {
        _allresultList.addAll(data.docs);
        _resultList.addAll(data.docs);
        for (var snapshot in _resultList) {
          print(snapshot.get('name'));
          print(snapshot.get('id'));
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
                Row(
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: () => {Navigator.pop(context)},
                        child: Text(
                          '< Back',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
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
                                            fr: _fruitlist.elementAt(index))),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  width: 500,
                                  height: 101,
                                  decoration: new BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(5),
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
                                        margin: EdgeInsets.all(5),
                                        width: 81,
                                        height: 77,
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              12.007169723510742),
                                        ),
                                        child: FutureBuilder(
                                          future: Storage.downloadURLExample(
                                              _fruitlist.elementAt(index).name),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<String> snapshot) {
                                            if (snapshot.connectionState ==
                                                    ConnectionState.done &&
                                                snapshot.hasData)
                                              return Image.network(
                                                snapshot.data!,
                                                fit: BoxFit.cover,
                                              );
                                            else if (snapshot.connectionState ==
                                                    ConnectionState.waiting ||
                                                !snapshot.hasData)
                                              return Container(
                                                  width: 10,
                                                  height: 10,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: dullgreen,
                                                    ),
                                                  ));
                                            else
                                              return Image.asset(
                                                  'assets/images/fruit.jpg');
                                          },
                                        ),
                                      ),
                                      Text(
                                        _fruitlist.elementAt(index).name,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: darkgreyblue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
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
        ),
      ),
    );
  }
}
