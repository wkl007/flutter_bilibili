import 'package:flutter/material.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';

class DarkModelItem extends StatelessWidget {
  const DarkModelItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var icon = Icons.nightlight_round;
    return InkWell(
      onTap: () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.darkMode,);
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 15,
          bottom: 15,
        ),
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          border: borderLine(context),
        ),
        child: Row(
          children: [
            Text(
              '夜间模式',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2, left: 10),
              child: Icon(icon),
            )
          ],
        ),
      ),
    );
  }
}
