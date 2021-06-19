import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 错误提示样式的toast
void showWarnToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: Color(0xfffb7299),
    textColor: Colors.white,
  );
}

/// 普通提示样式的toast
void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
  );
}
