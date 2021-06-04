enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  var pathParams;
  var useHttps = true;
  Map<String, String> params = Map();
  Map<String, dynamic> header = Map();

  // http 方法
  HttpMethod httpMethod();

  // 路径
  String path();

  // 是否需要登录
  bool needLogin();

  // 获取接口地址
  String authority() {
    return 'api.devio.org';
  }

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
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, pathParams);
    } else {
      uri = Uri.http(authority(), pathStr, pathParams);
    }
    print('url:${uri.toString()}');
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
}
