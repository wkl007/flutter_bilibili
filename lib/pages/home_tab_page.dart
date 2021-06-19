import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_model.dart';

class HomeTabPage extends StatefulWidget {
  /// 类别
  final String categoryName;
  final List<BannerList>? bannerList;

  const HomeTabPage({Key? key, required this.categoryName, this.bannerList})
      : super(key: key);

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
