import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/constants/size_config.dart';
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
        for (DocumentSnapshot snapshot in data.docs) {
          Post temp = Post.empty();
          temp.fromSnapshot(snapshot);
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
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.fromLTRB(
                2.64 * SizeConfig.heightMultiplier,
                4.64 * SizeConfig.heightMultiplier,
                2.64 * SizeConfig.heightMultiplier,
                2.64 * SizeConfig.heightMultiplier),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 86.77 * SizeConfig.heightMultiplier,
                            child: ListView.builder(
                                controller: scrollController,
                                itemCount: _allresultList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PostDetailScreen(
                                                    post: _listpost
                                                        .elementAt(index))),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Card(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            child: ShaderMask(
                                              shaderCallback: (rect) =>
                                                  LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.center,
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 58, 58, 58),
                                                  Colors.transparent,
                                                ],
                                              ).createShader(rect),
                                              blendMode: BlendMode.darken,
                                              child: Container(
                                                height: 32.57 *
                                                    SizeConfig.heightMultiplier,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          'assets/images/posttemplateimage.jpg'),
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors.black26,
                                                              BlendMode.darken),
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 20,
                                          left: 15,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 7),
                                            width: 76.34 *
                                                SizeConfig.widthMultiplier,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      _listpost
                                                          .elementAt(index)
                                                          .title,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      )),
                                                ),
                                              ],
                                            ),
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
            ),
          ),
        );
      });
    });
  }
}
