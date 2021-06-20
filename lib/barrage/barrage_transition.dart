import 'package:flutter/material.dart';

///弹幕移动动效
class BarrageTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final ValueChanged onComplete;

  const BarrageTransition(
      {Key? key,
      required this.duration,
      required this.onComplete,
      required this.child})
      : super(key: key);

  @override
  BarrageTransitionState createState() => BarrageTransitionState();
}

class BarrageTransitionState extends State<BarrageTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    //创建动画控制器
    _animationController =
        AnimationController(duration: widget.duration, vsync: this)
          ..addStatusListener((status) {
            //动画执行完毕之后的回调
            if (status == AnimationStatus.completed) {
              widget.onComplete('');
            }
          });
    //定义从右向左的补间动画
    var begin = Offset(1.0, 0);
    var end = Offset(-1.0, 0);
    _animation = Tween(begin: begin, end: end).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
