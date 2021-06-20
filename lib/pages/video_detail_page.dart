import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/widgets/video_view.dart';

/// 视频详情页
class VideoDetailPage extends StatefulWidget {
  final VideoModel videoInfo;

  const VideoDetailPage(this.videoInfo, {Key? key}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  VideoModel? videoInfo;

  @override
  initState() {
    super.initState();
    videoInfo = widget.videoInfo;
  }

  Widget _buildVideoView() {
    return VideoView(
      videoInfo!.url!,
      cover: videoInfo!.cover!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('视频vid:${widget.videoInfo.vid}'),
          Text('视频title:${widget.videoInfo.title}'),
          _buildVideoView(),
        ],
      ),
    );
  }
}
