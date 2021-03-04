import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/12
/// 版权： 江苏远大信息股份有限公司

class TopBarSelectTransition extends StatelessWidget {
  TopBarSelectTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Transform.translate(
              offset: Offset(
                animation.value, 0
                  // begin + (end ==  begin? 0: animation.value/(end - begin)),0
              ),
              child: child
            );
          },
          child: child
      ),
    );
  }
}