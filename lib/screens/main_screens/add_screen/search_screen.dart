import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => {Navigator.pop(context)},
        child: Text('Search Screen'),
      ),
    );
  }
}
