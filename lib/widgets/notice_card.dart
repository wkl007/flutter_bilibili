import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/util/format_util.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';

/// 通知列表卡片
class NoticeCard extends StatelessWidget {
  final BannerModel banner;

  /// banner 点击跳转
  void handleBannerClick(BannerModel banner) {
    if (banner.type == 'video') {
      print(banner.toString());
      HiNavigator.getInstance().onJumpTo(
        RouteStatus.detail,
        args: {'videoInfo': VideoModel(vid: banner.url)},
      );
    } else {
      HiNavigator.getInstance().openH5(banner.url);
    }
  }

  const NoticeCard({Key? key, required this.banner}) : super(key: key);

  _buildIcon() {
    var iconData = banner.type == 'video'
        ? Icons.ondemand_video_outlined
        : Icons.card_giftcard;
    return Icon(
      iconData,
      size: 30,
    );
  }

  Widget _buildContents() {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(banner.title, style: TextStyle(fontSize: 16)),
              Text(dateMonthAndDay(banner.createTime)),
            ],
          ),
          hiSpace(height: 5),
          Text(banner.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handleBannerClick(banner);
      },
      child: Container(
        decoration: BoxDecoration(border: borderLine(context)),
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildIcon(),
            hiSpace(width: 10),
            _buildContents(),
          ],
        ),
      ),
    );
  }
}
