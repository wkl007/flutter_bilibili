import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/profile_model.dart';
import 'package:flutter_bilibili/widgets/view_util.dart';

import 'hi_blur.dart';

/// 增值服务
class BenefitCard extends StatelessWidget {
  final List<Benefit> benefitList;

  const BenefitCard({Key? key, required this.benefitList}) : super(key: key);

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('增值服务',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          hiSpace(width: 10),
          Text(
            '购买后登录慕课网再次点击打开查看',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, Benefit benefit, double width) {
    return InkWell(
      onTap: () {
        //todo
        print('复制到剪切板与打开H5');
      },
      child: Padding(
        padding: EdgeInsets.only(right: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: 60,
            decoration: BoxDecoration(color: Colors.redAccent),
            child: Stack(
              children: [
                Positioned.fill(child: HiBlur()),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      benefit.name,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefit(BuildContext context) {
    //根据卡片数量计算出每个卡片的宽度
    var width = (MediaQuery.of(context).size.width -
            20 -
            (benefitList.length - 1) * 5) /
        benefitList.length;
    return Row(
      children: [
        ...benefitList.map((e) => _buildCard(context, e, width)).toSet()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [
          _buildTitle(),
          _buildBenefit(context),
        ],
      ),
    );
  }
}
