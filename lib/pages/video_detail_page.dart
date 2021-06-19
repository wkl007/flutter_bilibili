import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_model.dart';

/// 视频详情页
class VideoDetailPage extends StatefulWidget {
  final VideoModel videoInfo;

  const VideoDetailPage(this.videoInfo, {Key? key}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('详情页'),
          ],
        ),
      ),
    );
  }
}
