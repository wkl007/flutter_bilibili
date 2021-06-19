import 'package:flutter/material.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('首页'),
            MaterialButton(
              onPressed: () {
                // HiNavigator.getInstance().onJumpTo(RouteStatus.detail);
              },
              child: Text('详情'),
            ),
          ],
        ),
      ),
    );
  }
}
