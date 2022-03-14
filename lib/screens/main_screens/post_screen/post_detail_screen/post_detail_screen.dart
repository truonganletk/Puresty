import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
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
                        width: 406,
                        height: 172,
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
              Column(
                children: [
                  Container(
                      child: Text(post.content,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                          ))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
