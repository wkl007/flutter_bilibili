import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

/// 播放器组件
class VideoView extends StatefulWidget {
  /// 播放地址
  final String url;

  /// 封面
  final String cover;

  /// 自动播放
  final bool autoPlay;

  /// 循环播放
  final bool looping;

  /// 视频缩放比例
  final double aspectRatio;

  ///
  final Widget? overlayUI;

  ///
  final Widget? barrageUI;

  const VideoView(
    this.url, {
    Key? key,
    required this.cover,
    this.autoPlay = false,
    this.looping = false,
    this.aspectRatio = 16 / 9,
    this.overlayUI,
    this.barrageUI,
  }) : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  /// video_player播放器Controller
  late VideoPlayerController _videoPlayerController;

  /// chewie播放器Controller
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // 初始化播放器
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
    );
  }

  @override
  void dispose() {
    _chewieController.removeListener(() {});
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(controller: _chewieController),
    );
  }
}
