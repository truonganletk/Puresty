import 'package:flutter/material.dart';
//import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/constants/size_config.dart';
import 'package:puresty/models/post.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  const PostDetailScreen({Key? key, required this.post}) : super(key: key);
  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  String errorMessage = '';
  Post post = Post.empty();

  @override
  void initState() {
    super.initState();
    post = widget.post;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget content(String content) {
    var pwdWidgets = <Widget>[];
    for (var subcontent in content.split("/n")) {
      pwdWidgets.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Text(subcontent,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: black,
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
              )),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pwdWidgets,
    );
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: GestureDetector(
                            onTap: () => {Navigator.pop(context)},
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                            )),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x19000000),
                            offset: Offset(0, 2),
                            blurRadius: 10,
                            spreadRadius: 0)
                      ],
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: FittedBox(
                          child: Image.asset(
                            'assets/images/posttemplateimage.jpg',
                            width: 103.31 * SizeConfig.widthMultiplier,
                            height: 24.47 * SizeConfig.heightMultiplier,
                            fit: BoxFit.fill,
                          ),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(post.title,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: darkgreyblue,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                  content(post.content),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
