import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              Container(
                child: GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: Text(
                    '< Back',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Container(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: 'Enter a name',
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
              Container(
                width: 300,
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
                      width: 300,
                      height: 500,
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
                                width: 300,
                                height: 100,
                                color: Colors.cyan,
                                child: Center(
                                    child:
                                        Text(_fruitlist.elementAt(index).name)),
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
    );
  }
}
