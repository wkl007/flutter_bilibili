import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/model/video_detail_model.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widgets/appbar.dart';
import 'package:flutter_bilibili/widgets/expandable_content.dart';
import 'package:flutter_bilibili/widgets/hi_tab.dart';
import 'package:flutter_bilibili/widgets/navigation_bar.dart';
import 'package:flutter_bilibili/widgets/video_header.dart';
import 'package:flutter_bilibili/widgets/video_view.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';
import 'package:flutter_bilibili/http/dao/video_detail_dao.dart';

/// 视频详情页
class VideoDetailPage extends StatefulWidget {
  final VideoModel videoInfo;

  const VideoDetailPage(this.videoInfo, {Key? key}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  /// 控制器
  TabController? _controller;

  /// 视频信息
  VideoModel? videoInfo;

  /// 标签列表
  List<String> tabs = ['简介', '评论'];

  /// 详情信息
  VideoDetailModel? videoDetailInfo;

  /// 视频列表
  List<VideoModel> videoList = [];

  @override
  initState() {
    super.initState();
    videoInfo = widget.videoInfo;
    // 黑色状态栏，仅Android
    changeStatusBar(
      color: Colors.black,
      statusStyle: StatusStyle.LIGHT_CONTENT,
    );
    _controller = TabController(
      length: tabs.length,
      vsync: this,
    );
    _loadDetail();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // 获取数据
  void _loadDetail() async {
    try {
      VideoDetailModel result = await VideoDetailDao.get(videoInfo!.vid);
      setState(() {
        videoDetailInfo = result;
        // 更新旧的数据
        videoInfo = result.videoInfo;
        videoList = result.videoList;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  /// 播放器
  Widget _buildVideoView() {
    return VideoView(
      videoInfo!.url!,
      cover: videoInfo!.cover!,
      overlayUI: videoAppBar(),
    );
  }

  /// 底部
  Widget _buildTabNavigation() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: 39,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 选项卡
  Widget _tabBar() {
    return HiTab(
      tabs.map<Tab>((name) {
        return Tab(
          text: name,
        );
      }).toList(),
      controller: _controller,
    );
  }

  /// 底部详情
  Widget _buildDetailList() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        ...buildContents(),
        ..._buildVideoList(),
      ],
    );
  }

  List<Widget> buildContents() {
    return [
      VideoHeader(owner: videoInfo!.owner),
      ExpandableContent(videoInfo: videoInfo!)
    ];
  }

  List<Widget> _buildVideoList() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        removeTop: Platform.isIOS,
        context: context,
        child: videoInfo!.url != null
            ? Column(
                children: [
                  /// iOS 黑色状态栏
                  NavigationBar(
                    color: Colors.black,
                    statusStyle: StatusStyle.LIGHT_CONTENT,
                    height: Platform.isAndroid ? 0 : 46,
                  ),
                  _buildVideoView(),
                  _buildTabNavigation(),
                  Flexible(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        _buildDetailList(),
                        Container(
                          child: Text('敬请期待...'),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
