import 'package:fluro/fluro.dart' as Fluro;
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../../showcase/router/routers.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司

/// fluro的路由跳转工具类
class NavigatorUtils {

  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    unfocus();
    Routers.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }

  static void pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    unfocus();
    Routers.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((Object result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((dynamic error) {
      print('$error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, Object result) {
    unfocus();
    Navigator.pop<Object>(context, result);
  }

  static void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
