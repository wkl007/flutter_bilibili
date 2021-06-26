import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'barrage_model.dart';

class BarrageViewUtil {
  /// 如果想定义弹幕样式，可以在这里根据弹幕的类型来定义
  static barrageView(BarrageModel model) {
    switch (model.type) {
      case 1:
        return _barrageType1(model);
    }
    return Text(model.content, style: TextStyle(color: Colors.white));
  }

  /// 弹幕样式
  static _barrageType1(BarrageModel model) {
    return Center(
      child: Container(
        child: Text(
          model.content,
          style: TextStyle(color: Colors.deepOrangeAccent),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
