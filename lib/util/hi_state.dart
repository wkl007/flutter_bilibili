import 'package:flutter/material.dart';

/// 页面状态异常管理
abstract class HiState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      print('HiState:页面已销毁，本次setState不执行：${toString()}');
    }
  }
}
