import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/dao/notice_dao.dart';
import 'package:flutter_bilibili/model/home_model.dart';
import 'package:flutter_bilibili/model/notice_model.dart';
import 'package:flutter_bilibili/widgets/hi_base_tab_state.dart';
import 'package:flutter_bilibili/widgets/notice_card.dart';

/// 通知页
class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState
    extends HiBaseTabState<NoticeModel, BannerModel, NoticePage> {
  @override
  get contentChild => ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: dataList.length,
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>
            NoticeCard(banner: dataList[index]),
      );

  @override
  Future<NoticeModel> getData(int pageIndex) async {
    NoticeModel result =
        await NoticeDao.noticeList(pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<BannerModel> parseList(NoticeModel result) {
    return result.list;
  }

  _buildNavigationBar() {
    return AppBar(
      title: Text('通知'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildNavigationBar(),
          Expanded(child: super.build(context)),
        ],
      ),
    );
  }
}
