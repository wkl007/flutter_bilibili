import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/profile_dao.dart';
import 'package:flutter_bilibili/model/profile_model.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widgets/benefit_card.dart';
import 'package:flutter_bilibili/widgets/course_card.dart';
import 'package:flutter_bilibili/widgets/dart_mode_item.dart';
import 'package:flutter_bilibili/widgets/hi_banner.dart';
import 'package:flutter_bilibili/widgets/hi_blur.dart';
import 'package:flutter_bilibili/widgets/hi_flexible_header.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';

/// 个人中心
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  /// 个人信息
  ProfileModel? _profileInfo;

  /// 控制器
  ScrollController _controller = ScrollController();

  /// 缓存页面
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      ProfileModel result = await ProfileDao.get();
      setState(() {
        _profileInfo = result;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  _buildHead() {
    if (_profileInfo == null) return Container();
    return HiFlexibleHeader(
      name: _profileInfo!.name,
      face: _profileInfo!.face,
      controller: _controller,
    );
  }

  _buildAppBar() {
    return SliverAppBar(
      // 扩展高度
      expandedHeight: 160,
      // 标题栏是否固定
      pinned: true,
      // 定义股东空间
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
        background: Stack(
          children: [
            Positioned.fill(
              child: cachedImage(
                'https://www.devio.org/img/beauty_camera/beauty_camera4.jpg',
              ),
            ),
            Positioned.fill(child: HiBlur(sigma: 20)),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildProfileTab(),
            ),
          ],
        ),
      ),
    );
  }

  _buildContentList() {
    if (_profileInfo == null) {
      return [];
    }
    return [
      _buildBanner(),
      CourseCard(courseList: _profileInfo!.courseList),
      BenefitCard(benefitList: _profileInfo!.benefitList),
      DarkModelItem()
    ];
  }

  _buildBanner() {
    return HiBanner(
      _profileInfo!.bannerList,
      bannerHeight: 120,
      padding: EdgeInsets.only(left: 10, right: 10),
    );
  }

  _buildProfileTab() {
    if (_profileInfo == null) return Container();
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText('收藏', _profileInfo!.favorite),
          _buildIconText('点赞', _profileInfo!.like),
          _buildIconText('浏览', _profileInfo!.browsing),
          _buildIconText('金币', _profileInfo!.coin),
          _buildIconText('粉丝', _profileInfo!.fans),
        ],
      ),
    );
  }

  _buildIconText(String text, int count) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 15, color: Colors.black87)),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[_buildAppBar()];
        },
        body: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [..._buildContentList()],
        ),
      ),
    );
  }
}
