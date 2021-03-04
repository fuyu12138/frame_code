import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frame_code/frame/util/toast_util.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司

class DoubleTapBackExitApp extends StatefulWidget {

  const DoubleTapBackExitApp({
    Key key,
    @required this.child,
    this.duration = const Duration(milliseconds: 2500),
  }): super(key: key);

  final Widget child;

  final Duration duration;

  @override
  _DoubleTapBackExitAppState createState() => _DoubleTapBackExitAppState();

}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {

  DateTime  _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  Future<bool> _isExit() async {
    if (_lastTime == null || DateTime.now().difference(_lastTime) > widget.duration) {
      _lastTime = DateTime.now();
      toastShort('再次点击退出应用');
      return Future.value(false);
    }
    toastCancel();
    await SystemNavigator.pop();
    return Future.value(true);
  }
}