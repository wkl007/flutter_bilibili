import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/provider/theme_provider.dart';
import 'package:flutter_bilibili/util/format_util.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';
import 'package:provider/provider.dart';

class VideoCard extends StatelessWidget {
  final VideoModel videoInfo;

  const VideoCard({Key? key, required this.videoInfo}) : super(key: key);

  /// 图片
  Widget _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        cachedImage(
          videoInfo.cover ?? '',
          width: size.width / 2 - 10,
          height: 120,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 3,
              top: 5,
            ),
            decoration: BoxDecoration(
              // 渐变
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconText(Icons.ondemand_video, videoInfo.view ?? 0),
                _iconText(Icons.favorite_border, videoInfo.favorite ?? 0),
                _iconText(null, videoInfo.duration ?? 0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 图标文本
  _iconText(IconData? iconData, int count) {
    String views = "";
    if (iconData != null) {
      views = countFormat(count);
    } else {
      views = durationTransform(videoInfo.duration!);
    }
    return Row(
      children: [
        if (iconData != null) Icon(iconData, color: Colors.white, size: 12),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            views,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  /// 信息文本
  _infoText(Color textColor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          top: 5,
          left: 8,
          right: 8,
          bottom: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              videoInfo.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: textColor,
              ),
            ),
            _owner(textColor)
          ],
        ),
      ),
    );
  }

  /// 作者
  _owner(Color textColor) {
    var owner = videoInfo.owner;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: cachedImage(
                owner!.face,
                height: 24,
                width: 24,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                owner.name,
                style: TextStyle(
                  fontSize: 11,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
        Icon(
          Icons.more_vert_sharp,
          size: 15,
          color: Colors.grey,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    Color textColor = themeProvider.isDark() ? Colors.white70 : Colors.black87;
    return InkWell(
      onTap: () {
        HiNavigator.getInstance().onJumpTo(
          RouteStatus.detail,
          args: {'videoInfo': videoInfo},
        );
      },
      child: SizedBox(
        height: 200,
        child: Card(
          // 取消卡片默认边距
          margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemImage(context),
                _infoText(textColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
