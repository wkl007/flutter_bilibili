import 'dart:convert';
import 'package:flutter_bilibili/util/model_util.dart';

class HomeModel {
  HomeModel({
    this.bannerList,
    this.categoryList,
    required this.videoList,
  });

  factory HomeModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<BannerModel>? bannerList =
        jsonRes['bannerList'] is List ? <BannerModel>[] : null;
    if (bannerList != null) {
      for (final dynamic item in jsonRes['bannerList']!) {
        if (item != null) {
          bannerList
              .add(BannerModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<CategoryModel>? categoryList =
        jsonRes['categoryList'] is List ? <CategoryModel>[] : null;
    if (categoryList != null) {
      for (final dynamic item in jsonRes['categoryList']!) {
        if (item != null) {
          categoryList
              .add(CategoryModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<VideoModel>? videoList =
        jsonRes['videoList'] is List ? <VideoModel>[] : null;
    if (videoList != null) {
      for (final dynamic item in jsonRes['videoList']!) {
        if (item != null) {
          videoList.add(VideoModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return HomeModel(
      bannerList: bannerList,
      categoryList: categoryList,
      videoList: videoList!,
    );
  }

  List<BannerModel>? bannerList;
  List<CategoryModel>? categoryList;
  List<VideoModel> videoList;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'bannerList': bannerList,
        'categoryList': categoryList,
        'videoList': videoList,
      };

  HomeModel clone() => HomeModel.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class BannerModel {
  BannerModel({
    required this.id,
    required this.sticky,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.url,
    this.cover,
    required this.createTime,
  });

  factory BannerModel.fromJson(Map<String, dynamic> jsonRes) => BannerModel(
        id: asT<String>(jsonRes['id'])!,
        sticky: asT<int>(jsonRes['sticky'])!,
        type: asT<String>(jsonRes['type'])!,
        title: asT<String>(jsonRes['title'])!,
        subtitle: asT<String>(jsonRes['subtitle'])!,
        url: asT<String>(jsonRes['url'])!,
        cover: jsonRes['cover'],
        createTime: asT<String>(jsonRes['createTime'])!,
      );

  String id;
  int sticky;
  String type;
  String title;
  String subtitle;
  String url;
  String? cover;
  String createTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'sticky': sticky,
        'type': type,
        'title': title,
        'subtitle': subtitle,
        'url': url,
        'cover': cover,
        'createTime': createTime,
      };

  BannerModel clone() => BannerModel.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class CategoryModel {
  CategoryModel({
    required this.name,
    required this.count,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> jsonRes) => CategoryModel(
        name: asT<String>(jsonRes['name'])!,
        count: asT<int>(jsonRes['count'])!,
      );

  String name;
  int count;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'count': count,
      };

  CategoryModel clone() => CategoryModel.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class VideoModel {
  VideoModel({
    this.id,
    required this.vid,
    this.title,
    this.tname,
    this.url,
    this.cover,
    this.pubdate,
    this.desc,
    this.view,
    this.duration,
    this.owner,
    this.reply,
    this.favorite,
    this.like,
    this.coin,
    this.share,
    this.createTime,
    this.size,
  });

  factory VideoModel.fromJson(Map<String, dynamic> jsonRes) => VideoModel(
        id: asT<String>(jsonRes['id'])!,
        vid: asT<String>(jsonRes['vid'])!,
        title: asT<String>(jsonRes['title'])!,
        tname: asT<String>(jsonRes['tname'])!,
        url: asT<String>(jsonRes['url'])!,
        cover: asT<String>(jsonRes['cover'])!,
        pubdate: asT<int>(jsonRes['pubdate'])!,
        desc: asT<String>(jsonRes['desc'])!,
        view: asT<int>(jsonRes['view'])!,
        duration: asT<int>(jsonRes['duration'])!,
        owner: Owner.fromJson(asT<Map<String, dynamic>>(jsonRes['owner'])!),
        reply: asT<int>(jsonRes['reply'])!,
        favorite: asT<int>(jsonRes['favorite'])!,
        like: asT<int>(jsonRes['like'])!,
        coin: asT<int>(jsonRes['coin'])!,
        share: asT<int>(jsonRes['share'])!,
        createTime: asT<String>(jsonRes['createTime'])!,
        size: asT<int>(jsonRes['size'])!,
      );

  String? id;
  String vid;
  String? title;
  String? tname;
  String? url;
  String? cover;
  int? pubdate;
  String? desc;
  int? view;
  int? duration;
  Owner? owner;
  int? reply;
  int? favorite;
  int? like;
  int? coin;
  int? share;
  String? createTime;
  int? size;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'vid': vid,
        'title': title,
        'tname': tname,
        'url': url,
        'cover': cover,
        'pubdate': pubdate,
        'desc': desc,
        'view': view,
        'duration': duration,
        'owner': owner,
        'reply': reply,
        'favorite': favorite,
        'like': like,
        'coin': coin,
        'share': share,
        'createTime': createTime,
        'size': size,
      };

  VideoModel clone() => VideoModel.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Owner {
  Owner({
    required this.name,
    required this.face,
    required this.fans,
  });

  factory Owner.fromJson(Map<String, dynamic> jsonRes) => Owner(
        name: asT<String>(jsonRes['name'])!,
        face: asT<String>(jsonRes['face'])!,
        fans: asT<int>(jsonRes['fans'])!,
      );

  String name;
  String face;
  int fans;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'face': face,
        'fans': fans,
      };

  Owner clone() =>
      Owner.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
