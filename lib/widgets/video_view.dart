import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/services.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bilibili/widgets/hi_video_controls.dart';

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

  /// 视频浮层
  final Widget? overlayUI;

  /// 弹幕浮层
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

  /// 封面
  get _placeholder => FractionallySizedBox(
        widthFactor: 1,
        child: cachedImage(widget.cover),
      );

  /// 进度条颜色配置
  get _progressColors => ChewieProgressColors(
      playedColor: primary,
      handleColor: primary,
      backgroundColor: Colors.grey,
      bufferedColor: primary[50]!);

  /// 全屏监听
  void _fullScreenListener() {
    Size size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }

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
      placeholder: _placeholder,
      allowPlaybackSpeedChanging: false,
      customControls: MaterialControls(
        showLoadingOnInitialize: false,
        showBigPlayIcon: false,
        bottomGradient: blackLinearGradient(),
        overlayUI: widget.overlayUI,
        barrageUI: widget.barrageUI,
      ),
      materialProgressColors: _progressColors,
    );
    // fix iOS无法正常退出全屏播放问题
    _chewieController.addListener(_fullScreenListener);
  }

  @override
  void dispose() {
    _chewieController.removeListener(_fullScreenListener);
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
