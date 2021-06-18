import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/login_request.dart';
import 'package:flutter_bilibili/http/request/registration_request.dart';

class LoginDao {
  /// 登录令牌
  static const BOARDING_PASS = 'boarding-pass';

  /// 登录
  static Future<BaseRequest> login(String userName, String password) {
    return _send(userName, password);
  }

  /// 注册
  static Future<BaseRequest> registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  /// 发送
  static Future<BaseRequest> _send(String userName, String password,
      {String? imoocId, String? orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
      request.add('imoocId', imoocId).add('orderId', orderId);
    } else {
      request = LoginRequest();
    }
    request.add('userName', userName).add('password', password);

    var result = await HiNet.getInstance().fire(request);
    if (result['code'] == 0 && result['data'] != null) {
      // 保存登录令牌
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
    return request;
  }

  /// 获取登录令牌
  static String? getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
