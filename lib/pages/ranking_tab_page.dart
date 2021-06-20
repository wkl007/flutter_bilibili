import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/dao/ranking_dao.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/model/ranking_model.dart';
import 'package:flutter_bilibili/widgets/hi_base_tab_state.dart';
import 'package:flutter_bilibili/widgets/video_large_card.dart';

class RankingTabPage extends StatefulWidget {
  final String sort;

  const RankingTabPage({Key? key, required this.sort}) : super(key: key);

  @override
  _RankingTabPageState createState() => _RankingTabPageState();
}

class _RankingTabPageState
    extends HiBaseTabState<RankingModel, VideoModel, RankingTabPage> {
  @override
  get contentChild => Container(
        child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 10),
            itemCount: dataList.length,
            controller: scrollController,
            itemBuilder: (BuildContext context, int index) =>
                VideoLargeCard(videoInfo: dataList[index])),
      );

  @override
  Future<RankingModel> getData(int pageIndex) async {
    RankingModel result =
        await RankingDao.get(widget.sort, pageIndex: pageIndex, pageSize: 20);
    print(result.list.toString());
    return result;
  }

  @override
  List<VideoModel> parseList(RankingModel result) {
    return result.list;
  }
}
