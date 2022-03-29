import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => {Navigator.pop(context)},
        child: Text('Scan Screen'),
      ),
    );
  }
}
