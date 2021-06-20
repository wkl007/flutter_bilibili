import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/home_dao.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widgets/hi_banner.dart';
import 'package:flutter_bilibili/widgets/video_card.dart';
import 'package:flutter_nested/flutter_nested.dart';

class HomeTabPage extends StatefulWidget {
  /// 类别
  final String categoryName;

  /// 轮播图列表
  final List<BannerModel>? bannerList;

  const HomeTabPage({Key? key, required this.categoryName, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  /// 视频列表
  List<VideoModel> videoList = [];

  /// 第一页
  int pageIndex = 1;

  /// 页面缓存
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// 加载数据
  _loadData({loadMore: false}) async {
    try {
      if (!loadMore) pageIndex = 1;
      int currentIndex = pageIndex + (loadMore ? 1 : 0);
      HomeModel res = await HomeDao.get(widget.categoryName,
          pageIndex: currentIndex, pageSize: 50);
      setState(() {
        if (loadMore) {
          videoList = [...videoList, ...res.videoList];
          if (res.videoList.length != 0) {
            pageIndex++;
          }
        } else {
          videoList = res.videoList;
        }
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    }
  }

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
      child: HiNestedScrollView(
        itemCount: videoList.length,
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        headers: [
          if (widget.bannerList != null)
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: _banner(widget.bannerList!),
            ),
        ],
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.95),
        itemBuilder: (BuildContext context, int index) {
          return VideoCard(videoInfo: videoList[index]);
        },
      ),
    );
  }
}
