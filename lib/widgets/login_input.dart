import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bilibili/util/color.dart';

/// 登录输入框
class LoginInput extends StatefulWidget {
  /// 标题
  final String title;

  /// 提示文字
  final String hint;

  /// 底部线边距
  final bool lineStretch;

  /// 隐藏文本
  final bool obscureText;

  /// 键盘类型
  final TextInputType? keyboardType;

  /// 输入事件
  final ValueChanged<String>? onChanged;

  /// 聚焦事件
  final ValueChanged<bool>? focusChanged;

  const LoginInput(this.title, this.hint,
      {Key? key,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType,
      this.onChanged,
      this.focusChanged})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 是否获取光标的监听
    _focusNode.addListener(() {
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  /// 输入框
  Widget _input() {
    return Expanded(
      child: TextField(
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        autofocus: !widget.obscureText,
        cursorColor: primary,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
        // 输入框的样式
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: widget.lineStretch ? 15 : 0),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }
}
