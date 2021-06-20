import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/cancel_favorite_request.dart';
import 'package:flutter_bilibili/http/request/favorite_request.dart';

class FavoriteDao {
  static favorite(String vid, bool favorite) async {
    BaseRequest request =
        favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    return result;
  }

  static favoriteList({int pageIndex = 1, int pageSize = 10}) async {}
}
