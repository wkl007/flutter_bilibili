import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// 带 lottie 动画的加载进度条组件
class LoadingContainer extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 加载状态
  final bool isLoading;

  /// 加载动画是否覆盖在原有界面上
  final bool cover;

  const LoadingContainer({
    Key? key,
    required this.child,
    this.isLoading = false,
    this.cover = false,
  }) : super(key: key);

  /// lottie动画
  Widget get _loadingView {
    return Center(child: Lottie.asset('assets/json/loading.json'));
  }

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [
          child,
          isLoading ? _loadingView : Container(),
        ],
      );
    } else {
      return isLoading ? _loadingView : child;
    }
  }
}
