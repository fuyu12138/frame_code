
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frame_code/frame/router/fluro_navigation.dart';
import 'package:frame_code/showcase/router/routers.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司
/// 欢迎页

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();
    countDown();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
              children: [
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                        "$_countdownNum秒"
                    ),
                  ),
                ),
                Center(
                    child:Text(
                      'Welcome to Sinoyd Flutter Frame',
                    )
                )
              ],
            )
    );
  }

  Timer _timer;
  int _countdownNum = 3;
  void countDown() {
    setState(() {
      if(_timer != null) {
        return;
      }
      _timer =  _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if(_countdownNum > 1) {
            _countdownNum --;
          }else {
            _goHomePage();
          }
        });
      });
    });
  }

  void _goHomePage() {
    NavigatorUtils.push(context, Routers.main, replace: true);
    return null;
  }
}