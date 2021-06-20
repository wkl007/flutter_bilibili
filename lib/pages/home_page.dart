import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/home_dao.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/pages/home_tab_page.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/hi_state.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widgets/navigation_bar.dart';
import 'package:underline_indicator/underline_indicator.dart';

/// 首页
class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;

  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController? _controller;

  /// 类别列表
  List<CategoryModel> categoryList = [];

  /// 轮播图列表
  List<BannerModel> bannerList = [];

  /// 加载状态
  bool _isLoading = true;

  /// 缓存页面
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    loadData();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  /// 加载数据
  void loadData() async {
    try {
      HomeModel res = await HomeDao.get('推荐');
      if (res.categoryList != null) {
        _controller =
            TabController(length: res.categoryList?.length ?? 0, vsync: this);
      }
      setState(() {
        categoryList = res.categoryList ?? [];
        bannerList = res.bannerList ?? [];
        _isLoading = false;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    } on HiNetError catch (e) {
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// appBar
  Widget _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                height: 46,
                width: 46,
                image: AssetImage('assets/images/avatar.png'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 32,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.search, color: Colors.grey),
                  decoration: BoxDecoration(color: Colors.grey[100]),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // _mockCrash();
            },
            child: Icon(
              Icons.explore_outlined,
              color: Colors.grey,
            ),
          ),
          InkWell(
            onTap: () {
              HiNavigator.getInstance().onJumpTo(RouteStatus.notice);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.mail_outline,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 顶部 Tab
  Widget _tabBar() {
    return TabBar(
      controller: _controller,
      isScrollable: true,
      labelColor: Colors.black54,
      indicator: UnderlineIndicator(
        strokeCap: StrokeCap.square,
        borderSide: BorderSide(color: primary, width: 3),
        insets: EdgeInsets.only(left: 15, right: 15),
      ),
      tabs: categoryList.map<Tab>((tab) {
        return Tab(
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              tab.name,
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          NavigationBar(
            child: _appBar(),
            height: 50,
            color: Colors.white,
            statusStyle: StatusStyle.DARK_CONTENT,
          ),
          Container(
            color: Colors.white,
            child: _tabBar(),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: categoryList.map((tab) {
                return HomeTabPage(
                  categoryName: tab.name,
                  bannerList: tab.name == '推荐' ? bannerList : null,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
