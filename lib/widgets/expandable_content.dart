import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';

/// 可展开的widget
class ExpandableContent extends StatefulWidget {
  final VideoModel videoInfo;

  const ExpandableContent({Key? key, required this.videoInfo})
      : super(key: key);

  @override
  _ExpandableContentState createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  bool _expand = false;

  //用来管理Animation
  AnimationController? _controller;

  //生成动画高度的值
  Animation<double>? _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller?.drive(_easeInTween);
    _controller?.addListener(() {
      //监听动画值的变化
      print(_heightFactor?.value);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _buildTitle() {
    return InkWell(
      onTap: _toggleExpand,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //通过Expanded让Text获得最大宽度，以便显示省略号
          Expanded(
            child: Text(
              widget.videoInfo.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 15)),
          Icon(
            _expand
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp,
            color: Colors.grey,
            size: 16,
          )
        ],
      ),
    );
  }

  void _toggleExpand() {
    setState(() {
      _expand = !_expand;
      if (_expand) {
        //执行动画
        _controller?.forward();
      } else {
        //反向执行动画
        _controller?.reverse();
      }
    });
  }

  _buildInfo() {
    var style = TextStyle(fontSize: 12, color: Colors.grey);
    var dateStr = widget.videoInfo.createTime!.length > 10
        ? widget.videoInfo.createTime!.substring(5, 10)
        : widget.videoInfo.createTime;
    return Row(
      children: [
        ...smallIconText(Icons.ondemand_video, widget.videoInfo.view),
        Padding(padding: EdgeInsets.only(left: 10)),
        ...smallIconText(Icons.list_alt, widget.videoInfo.reply),
        Text('    $dateStr', style: style)
      ],
    );
  }

  _buildDes() {
    var child = _expand
        ? Text(
            widget.videoInfo.desc ?? '',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        : null;
    // 构建动画的通用widget
    return AnimatedBuilder(
      animation: _controller!.view,
      child: child,
      builder: (BuildContext context, Widget? child) {
        return Align(
          heightFactor: _heightFactor!.value,
          //fix 从布局之上的位置开始展开
          alignment: Alignment.topCenter,
          child: Container(
            //会撑满宽度后，让内容对其
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 8),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 5,
      ),
      child: Column(
        children: [
          _buildTitle(),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
          ),
          _buildInfo(),
          _buildDes()
        ],
      ),
    );
  }
}
