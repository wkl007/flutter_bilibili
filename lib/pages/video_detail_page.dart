import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/widgets/appbar.dart';
import 'package:flutter_bilibili/widgets/navigation_bar.dart';
import 'package:flutter_bilibili/widgets/video_view.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';

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
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildVideoView() {
    return VideoView(
      videoInfo!.url!,
      cover: videoInfo!.cover!,
      overlayUI: videoAppBar(),
    );
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
                ],
              )
            : Container(),
      ),
    );
  }
}
