import 'package:flutter/material.dart';
import 'package:flutter_bilibili/widgets/login_input.dart';

/// 注册页面
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;
  String? rePassword;
  String? imoocId;
  String? orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 自适应键盘弹起，防止遮挡
        child: ListView(
          children: [
            LoginInput(
              '用户名',
              '请输入用户名',
              onChanged: (text) {
                userName = text;
              },
            ),
            LoginInput(
              '密码',
              '请输入密码',
              obscureText: true,
              onChanged: (text) {
                password = text;
              },
              focusChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              '确认密码',
              '请再次输入密码',
              lineStretch: true,
              obscureText: true,
              onChanged: (text) {
                rePassword = text;
              },
              focusChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              '慕课网ID',
              '请输入你的慕课网用户ID',
              keyboardType: TextInputType.number,
              onChanged: (text) {
                imoocId = text;
              },
            ),
            LoginInput(
              '课程订单号',
              '请输入课程订单号后四位',
              keyboardType: TextInputType.number,
              lineStretch: true,
              onChanged: (text) {
                orderId = text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
