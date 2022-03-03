import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/models/post.dart';
import 'package:puresty/screens/main_screens/post_screen/post_detail_screen/post_detail_screen.dart';

class PostScreen extends StatefulWidget {
  // final DocumentSnapshot userdata;
  // const Search({Key key, @required this.userdata}) : super(key: key);
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    getallPost();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  final scrollController = ScrollController();
  String errorMessage = '';
  bool isFetching = false;
  int documentLimit = 5;
  List _allresultList = [];
  List<Post> _listpost = [];
  getallPost() async {
    //if (isFetching) return;
    errorMessage = '';
    isFetching = true;
    try {
      var posts =
          FirebaseFirestore.instance.collection('posts').limit(documentLimit);
      final startAfter = _allresultList.isNotEmpty ? _allresultList.last : null;
      var data;
      if (startAfter == null) {
        data = await posts.get();
      } else {
        data = await posts.startAfterDocument(startAfter).get();
      }
      setState(() {
        _allresultList.addAll(data.docs);
        for (DocumentSnapshot Snapshot in data.docs) {
          Post temp = Post.empty();
          temp.fromSnapshot(Snapshot);
          _listpost.add(temp);
        }
      });
      // if (data.docs.length < documentLimit)
      //   setState(() {
      //     hasNext = false;
      //   });
      print('get all post successful');
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
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Post",
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
                          padding: const EdgeInsets.all(8),
                          controller: scrollController,
                          itemCount: _allresultList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostDetailScreen(
                                          post: _listpost.elementAt(index))),
                                );
                              },
                              child: Container(
                                width: 300,
                                height: 100,
                                color: Colors.pinkAccent,
                                child: Center(child: Text('<3')),
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
