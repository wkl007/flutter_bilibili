import 'dart:convert';
import 'package:flutter_bilibili/util/model_util.dart';

class HomeModel {
  HomeModel({
    this.bannerList,
    this.categoryList,
    required this.videoList,
  });

  factory HomeModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<BannerList>? bannerList =
        jsonRes['bannerList'] is List ? <BannerList>[] : null;
    if (bannerList != null) {
      for (final dynamic item in jsonRes['bannerList']!) {
        if (item != null) {
          bannerList.add(BannerList.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<CategoryList>? categoryList =
        jsonRes['categoryList'] is List ? <CategoryList>[] : null;
    if (categoryList != null) {
      for (final dynamic item in jsonRes['categoryList']!) {
        if (item != null) {
          categoryList
              .add(CategoryList.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<VideoList>? videoList =
        jsonRes['videoList'] is List ? <VideoList>[] : null;
    if (videoList != null) {
      for (final dynamic item in jsonRes['videoList']!) {
        if (item != null) {
          videoList.add(VideoList.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return HomeModel(
      bannerList: bannerList,
      categoryList: categoryList,
      videoList: videoList!,
    );
  }

  List<BannerList>? bannerList;
  List<CategoryList>? categoryList;
  List<VideoList> videoList;

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

class BannerList {
  BannerList({
    required this.id,
    required this.sticky,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.cover,
    required this.createTime,
  });

  factory BannerList.fromJson(Map<String, dynamic> jsonRes) => BannerList(
        id: asT<String>(jsonRes['id'])!,
        sticky: asT<int>(jsonRes['sticky'])!,
        type: asT<String>(jsonRes['type'])!,
        title: asT<String>(jsonRes['title'])!,
        subtitle: asT<String>(jsonRes['subtitle'])!,
        url: asT<String>(jsonRes['url'])!,
        cover: asT<String>(jsonRes['cover'])!,
        createTime: asT<String>(jsonRes['createTime'])!,
      );

  String id;
  int sticky;
  String type;
  String title;
  String subtitle;
  String url;
  String cover;
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

  BannerList clone() => BannerList.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class CategoryList {
  CategoryList({
    required this.name,
    required this.count,
  });

  factory CategoryList.fromJson(Map<String, dynamic> jsonRes) => CategoryList(
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

  CategoryList clone() => CategoryList.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class VideoList {
  VideoList({
    required this.id,
    required this.vid,
    required this.title,
    required this.tname,
    required this.url,
    required this.cover,
    required this.pubdate,
    required this.desc,
    required this.view,
    required this.duration,
    required this.owner,
    required this.reply,
    required this.favorite,
    required this.like,
    required this.coin,
    required this.share,
    required this.createTime,
    required this.size,
  });

  factory VideoList.fromJson(Map<String, dynamic> jsonRes) => VideoList(
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

  String id;
  String vid;
  String title;
  String tname;
  String url;
  String cover;
  int pubdate;
  String desc;
  int view;
  int duration;
  Owner owner;
  int reply;
  int favorite;
  int like;
  int coin;
  int share;
  String createTime;
  int size;

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

  VideoList clone() => VideoList.fromJson(
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
