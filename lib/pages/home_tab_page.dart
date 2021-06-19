import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/widgets/hi_banner.dart';

class HomeTabPage extends StatefulWidget {
  /// 类别
  final String categoryName;
  final List<BannerModel>? bannerList;

  const HomeTabPage({Key? key, required this.categoryName, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  /// 轮播图
  _banner(List<BannerModel> bannerList) {
    return HiBanner(
      bannerList,
      padding: EdgeInsets.only(left: 5, right: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView(
        children: [
          if (widget.bannerList != null) _banner(widget.bannerList!),
        ],
      ),
    );
  }
}
