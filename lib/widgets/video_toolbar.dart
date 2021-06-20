import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/model/video_detail_model.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/format_util.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';

/// 视频点赞分享收藏等工具栏
class VideoToolBar extends StatelessWidget {
  /// 详情信息
  final VideoDetailModel? detailInfo;

  /// 视频信息
  final VideoModel videoInfo;

  /// 喜欢事件
  final VoidCallback? onLike;

  /// 不喜欢事件
  final VoidCallback? onUnLike;

  /// 打赏事件
  final VoidCallback? onCoin;

  /// 收藏事件
  final VoidCallback? onFavorite;

  /// 分享事件
  final VoidCallback? onShare;

  const VideoToolBar({
    Key? key,
    this.detailInfo,
    required this.videoInfo,
    this.onLike,
    this.onUnLike,
    this.onCoin,
    this.onFavorite,
    this.onShare,
  }) : super(key: key);

  /// 按钮文本
  _buildIconText(IconData iconData, text, {onClick, bool tint = false}) {
    if (text is int) {
      //显示格式化
      text = countFormat(text);
    } else if (text == null) {
      text = '';
    }
    tint = tint == null ? false : tint;
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(
            iconData,
            color: tint ? primary : Colors.grey,
            size: 20,
          ),
          hiSpace(height: 5),
          Text(text, style: TextStyle(color: Colors.grey, fontSize: 12))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(border: borderLine(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(
            Icons.thumb_up_alt_rounded,
            videoInfo.like,
            onClick: onLike,
            tint: detailInfo?.isLike ?? false,
          ),
          _buildIconText(
            Icons.thumb_down_alt_rounded,
            '不喜欢',
            onClick: onUnLike,
          ),
          _buildIconText(
            Icons.monetization_on,
            videoInfo.coin,
            onClick: onCoin,
          ),
          _buildIconText(
            Icons.grade_rounded,
            videoInfo.favorite,
            onClick: onFavorite,
            tint: detailInfo?.isFavorite ?? false,
          ),
          _buildIconText(
            Icons.share_rounded,
            videoInfo.share,
            onClick: onShare,
          ),
        ],
      ),
    );
  }
}
