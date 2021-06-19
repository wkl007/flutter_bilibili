import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel> onJumpToDetail;

  const HomePage({Key? key, required this.onJumpToDetail}) : super(key: key);

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
              onPressed: () => widget.onJumpToDetail(VideoModel(123)),
              child: Text('详情'),
            ),
          ],
        ),
      ),
    );
  }
}
