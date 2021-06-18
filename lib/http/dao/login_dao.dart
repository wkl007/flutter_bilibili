import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/login_request.dart';
import 'package:flutter_bilibili/http/request/registration_request.dart';

class LoginDao {
  /// 登录
  static login(String userName, String password) {
    return _send(userName, password);
  }

  /// 注册
  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  /// 发送
  static _send(String userName, String password,
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
    print(result);
    return request;
  }
}
