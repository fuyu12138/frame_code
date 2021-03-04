import 'package:fluro/fluro.dart';
import 'package:frame_code/frame/router/i_router.dart';
import 'package:frame_code/showcase/page/home/page/home_page.dart';
import 'package:frame_code/showcase/page/login/page/login_page.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司

class HomeRouter implements IRouterProvider {

  static String home = "/home";

  @override
  void initRouter(Router router) {
    router.define(home, handler: Handler(handlerFunc: (_, __) => HomePage()));
  }
}