import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widgets/appbar.dart';
import 'package:flutter_bilibili/widgets/login_button.dart';
import 'package:flutter_bilibili/widgets/login_effect.dart';
import 'package:flutter_bilibili/widgets/login_input.dart';
import 'package:flutter_bilibili/util/string_util.dart';

/// 注册页
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  /// 是否保护
  bool protect = false;

  /// 按钮是否可点击
  bool loginEnable = false;

  /// 用户名
  String? userName;

  /// 密码
  String? password;

  /// 确认密码
  String? rePassword;

  /// 慕课网 id
  String? imoocId;

  /// 订单 id
  String? orderId;

  /// 设置按钮启用
  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  /// 检查密码
  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = '两次密码不一致';
    } else if (orderId?.length != 4) {
      tips = "请输入订单号的后四位";
    }
    if (tips != null) {
      showWarnToast(tips);
      return;
    }
    send();
  }

  /// 注册
  void send() async {
    try {
      var result =
          await LoginDao.registration(userName!, password!, imoocId!, orderId!);
      if (result['code'] == 0) {
        showToast('注册成功');
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      } else {
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('注册', '登录', () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      }),
      body: Container(
        // 自适应键盘弹起，防止遮挡
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              '用户名',
              '请输入用户名',
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              '密码',
              '请输入密码',
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
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
                checkInput();
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
                checkInput();
              },
            ),
            LoginInput(
              '课程订单号',
              '请输入课程订单号后四位',
              keyboardType: TextInputType.number,
              lineStretch: true,
              onChanged: (text) {
                orderId = text;
                checkInput();
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton(
                '注册',
                enable: loginEnable,
                onPressed: checkParams,
              ),
            )
          ],
        ),
      ),
    );
  }
}
