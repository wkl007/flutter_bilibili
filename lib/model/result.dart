import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的
/// flutter packages pub run build_runner build
@JsonSerializable()
class Result {
  int code;
  String method;
  String requestParams;

  Result({
    required this.code,
    required this.method,
    required this.requestParams,
  });

  // 固定格式，不同的类使用不同的mixin即可
  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  // 固定格式
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
