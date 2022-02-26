import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          Container(
            child: GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Text(
                'Back',
                style: TextStyle(fontSize: 50),
              ),
            ),
          ),
          Text(post.title),
          Text(post.content)
        ],
      ),
    );
  }
}
