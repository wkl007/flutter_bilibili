import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;

  const HomeTabPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.categoryName),
    );
  }
}
