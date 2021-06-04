import 'package:flutter_bilibili/http/request/base_request.dart';

class TestRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    // TODO: implement httpMethod
    throw UnimplementedError();
  }

  @override
  bool needLogin() {
    // TODO: implement needLogin
    throw UnimplementedError();
  }

  @override
  String path() {
    // TODO: implement path
    throw UnimplementedError();
  }
}
