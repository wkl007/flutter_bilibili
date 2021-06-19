import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/util/hi_constants.dart';

enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  Map<String, dynamic> header = {
    HiConstants.authTokenK: HiConstants.authTokenV,
    HiConstants.courseFlagK: HiConstants.courseFlagV
  };

  Map<String, String> params = Map();

  // 获取接口地址
  String authority() {
    return 'api.devio.org';
  }

  // http 方法
  HttpMethod httpMethod();

  // 是否需要登录
  bool needLogin();

  // 路径
  String path();

  // 拼接 url
  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接 path 参数
    if (pathParams != null) {
      if (path().endsWith('/')) {
        pathStr = '${path()}$pathParams';
      } else {
        pathStr = '${path()}/$pathParams';
      }
    }
    // http 和 https 切换
    bool flag = isEmpty(params);
    if (useHttps) {
      uri = !flag
          ? Uri.https(authority(), pathStr, params)
          : Uri.https(authority(), pathStr);
    } else {
      uri = !flag
          ? Uri.http(authority(), pathStr, params)
          : Uri.http(authority(), pathStr);
    }
    var boardingPass = LoginDao.getBoardingPass();
    if (needLogin() && boardingPass != null) {
      // 给需要登录的接口携带登录令牌
      addHeader(LoginDao.BOARDING_PASS, boardingPass);
    }
    print('请求url:$uri');
    print('请求头:$header');
    print('请求参:$params');
    return uri.toString();
  }

  // 添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  // 添加 header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }

  // 检查对象或 List 或 Map 是否为空
  bool isEmpty(Object object) {
    if (object is String && object.isEmpty) {
      return true;
    } else if (object is List && object.isEmpty) {
      return true;
    } else if (object is Map && object.isEmpty) {
      return true;
    }
    return false;
  }
}
