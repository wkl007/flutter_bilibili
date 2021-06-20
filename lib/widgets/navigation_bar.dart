import 'package:flutter/material.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

/// 可自定义样式的沉浸式导航栏
class NavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  const NavigationBar({
    Key? key,
    this.statusStyle = StatusStyle.DARK_CONTENT,
    this.color = Colors.white,
    this.height = 46,
    this.child,
  }) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  var _statusStyle;
  var _color;

  /// 沉浸式状态栏
  void _statusBarInit() {
    changeStatusBar(color: _color, statusStyle: _statusStyle);
  }

  @override
  Widget build(BuildContext context) {
    _color = widget.color;
    _statusStyle = widget.statusStyle;
    _statusBarInit();

    // 状态栏高度
    double top = MediaQuery.of(context).padding.top;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: _color),
    );
  }
}
