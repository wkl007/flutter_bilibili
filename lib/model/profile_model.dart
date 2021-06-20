import 'dart:convert';

import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/util/model_util.dart';

class ProfileModel {
  ProfileModel({
    required this.name,
    required this.face,
    required this.fans,
    required this.favorite,
    required this.like,
    required this.coin,
    required this.browsing,
    required this.bannerList,
    required this.courseList,
    required this.benefitList,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> jsonRes) {
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

    final List<Course>? courseList =
        jsonRes['courseList'] is List ? <Course>[] : null;
    if (courseList != null) {
      for (final dynamic item in jsonRes['courseList']!) {
        if (item != null) {
          courseList.add(Course.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<Benefit>? benefitList =
        jsonRes['benefitList'] is List ? <Benefit>[] : null;
    if (benefitList != null) {
      for (final dynamic item in jsonRes['benefitList']!) {
        if (item != null) {
          benefitList
              .add(Benefit.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ProfileModel(
      name: asT<String>(jsonRes['name'])!,
      face: asT<String>(jsonRes['face'])!,
      fans: asT<int>(jsonRes['fans'])!,
      favorite: asT<int>(jsonRes['favorite'])!,
      like: asT<int>(jsonRes['like'])!,
      coin: asT<int>(jsonRes['coin'])!,
      browsing: asT<int>(jsonRes['browsing'])!,
      bannerList: bannerList!,
      courseList: courseList!,
      benefitList: benefitList!,
    );
  }

  String name;
  String face;
  int fans;
  int favorite;
  int like;
  int coin;
  int browsing;
  List<BannerModel> bannerList;
  List<Course> courseList;
  List<Benefit> benefitList;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'face': face,
        'fans': fans,
        'favorite': favorite,
        'like': like,
        'coin': coin,
        'browsing': browsing,
        'bannerList': bannerList,
        'courseList': courseList,
        'benefitList': benefitList,
      };

  ProfileModel clone() => ProfileModel.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Course {
  Course({
    required this.name,
    required this.cover,
    required this.url,
    required this.group,
  });

  factory Course.fromJson(Map<String, dynamic> jsonRes) => Course(
        name: asT<String>(jsonRes['name'])!,
        cover: asT<String>(jsonRes['cover'])!,
        url: asT<String>(jsonRes['url'])!,
        group: asT<int>(jsonRes['group'])!,
      );

  String name;
  String cover;
  String url;
  int group;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'cover': cover,
        'url': url,
        'group': group,
      };

  Course clone() => Course.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Benefit {
  Benefit({
    required this.name,
    required this.url,
  });

  factory Benefit.fromJson(Map<String, dynamic> jsonRes) => Benefit(
        name: asT<String>(jsonRes['name'])!,
        url: asT<String>(jsonRes['url'])!,
      );

  String name;
  String url;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'url': url,
      };

  Benefit clone() => Benefit.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
