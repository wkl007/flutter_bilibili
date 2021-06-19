import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/http/request/notice_request.dart';
import 'package:flutter_bilibili/pages/home_page.dart';
import 'package:flutter_bilibili/pages/login_page.dart';
import 'package:flutter_bilibili/pages/registration_page.dart';
import 'package:flutter_bilibili/pages/video_detail_page.dart';
import 'package:flutter_bilibili/util/color.dart';

import 'model/video_model.dart';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  BiliRouteInformationParser _routeInformationParser =
      BiliRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    var widget = Router(
      routerDelegate: _routeDelegate,
      routeInformationParser: _routeInformationParser,

      /// routeInformationParser 为null时可省略
      routeInformationProvider: PlatformRouteInformationProvider(
        initialRouteInformation: RouteInformation(location: '/'),
      ),
    );

    return MaterialApp(
      home: widget,
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  // 为 Navigator 设置一个 key，必要时可以通过navigatorKey.currentState 来获取到 navigatorState 对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<MaterialPage> pages = [];

  VideoModel? videoModel;
  BiliRoutePath? path;

  @override
  Widget build(BuildContext context) {
    // 构建路由堆栈
    pages = [
      pageWrap(HomePage(onJumpToDetail: (videoModel) {
        this.videoModel = videoModel;
        notifyListeners();
      })),
      if (videoModel != null)
        pageWrap(VideoDetailPage(videoModel: videoModel!)),
    ];
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        // 此处可以控制是否返回
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {
    this.path = path;
  }
}

/// 可缺省，主要应用与web
class BiliRouteInformationParser extends RouteInformationParser<BiliRoutePath> {
  @override
  Future<BiliRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    print('uri:$uri');
    if (uri.pathSegments.length == 0) {
      return BiliRoutePath.home();
    }
    return BiliRoutePath.detail();
  }
}

/// 定义路由数据
class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = '/';

  BiliRoutePath.detail() : location = '/detail';
}

/// 创建页面
MaterialPage pageWrap(Widget child) {
  return MaterialPage(
    key: ValueKey(child.hashCode),
    child: child,
  );
}
