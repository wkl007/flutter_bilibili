import 'package:flutter/material.dart';

/// 登录动效
class LoginEffect extends StatefulWidget {
  /// 是否保护
  final bool protect;

  const LoginEffect({Key? key, required this.protect}) : super(key: key);

  @override
  _LoginEffectState createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  /// 图片
  Widget _image(bool left) {
    var headLeft = widget.protect
        ? 'assets/images/head_left_protect.png'
        : 'assets/images/head_left.png';
    var headRight = widget.protect
        ? 'assets/images/head_right_protect.png'
        : 'assets/images/head_right.png';
    return Image(
      image: AssetImage(left ? headLeft : headRight),
      height: 90,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          Image(
            height: 90,
            width: 90,
            image: AssetImage('assets/images/logo.png'),
          ),
          _image(false),
        ],
      ),
    );
  }
}
