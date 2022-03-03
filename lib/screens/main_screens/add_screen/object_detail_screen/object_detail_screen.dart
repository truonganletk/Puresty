import 'package:flutter/material.dart';
import 'package:puresty/models/fruit.dart';

class ObjectDetail extends StatefulWidget {
  final Fruit fr;
  const ObjectDetail({Key? key, required this.fr}) : super(key: key);
  @override
  State<ObjectDetail> createState() => _ObjectDetailState();
}

class _ObjectDetailState extends State<ObjectDetail> {
  String errorMessage = '';
  Fruit fr = Fruit.empty();

  @override
  void initState() {
    super.initState();
    fr = widget.fr;
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
          Text(fr.name),
          Text(fr.cal.toString()),
          Text(fr.carbs.toString()),
          Text(fr.fats.toString()),
          Text(fr.protein.toString()),
          Text(fr.fibre.toString()),
        ],
      ),
    );
  }
}
