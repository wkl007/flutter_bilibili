import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/home_dao.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/pages/home_tab_page.dart';
import 'package:flutter_bilibili/pages/profile_page.dart';
import 'package:flutter_bilibili/pages/video_detail_page.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/hi_state.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widgets/loading_container.dart';
import 'package:flutter_bilibili/widgets/navigation_bar.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';
import 'package:underline_indicator/underline_indicator.dart';

/// 首页
class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;

  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  /// 路由监听器
  var listener;

  /// 控制器
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
    WidgetsBinding.instance?.addObserver(this);
    _controller = TabController(
      length: categoryList.length,
      vsync: this,
    );
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      // 当页面返回到首页恢复首页的状态栏样式
      if (pre?.page is VideoDetailPage && !(current.page is ProfilePage)) {
        var statusStyle = StatusStyle.DARK_CONTENT;
        changeStatusBar(color: Colors.white, statusStyle: statusStyle);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    HiNavigator.getInstance().removeListener(this.listener);
    _controller?.dispose();
    super.dispose();
  }

  /// 监听应用生命周期变化
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
      case AppLifecycleState.inactive:
        break;
      // 从后台切换前台，界面可见
      case AppLifecycleState.resumed:
        // fix Android 压后台首页状态栏字体颜色变白，详情页状态栏字体变黑问题
        changeStatusBar();
        break;
      // 界面不可见，后台
      case AppLifecycleState.paused:
        break;
      // APP 结束时调用
      case AppLifecycleState.detached:
        break;
    }
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
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Column(
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
      ),
    );
  }
}
