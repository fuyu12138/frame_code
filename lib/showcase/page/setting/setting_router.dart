
import 'package:fluro/fluro.dart';
import 'package:frame_code/frame/router/i_router.dart';
import 'package:frame_code/showcase/page/setting/page/about_page.dart';
import 'package:frame_code/showcase/page/setting/page/setting_page.dart';
/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司

class SettingRouter implements IRouterProvider {

  static String setting = "/setting";
  static String about = "/setting/about";


  @override
  void initRouter(Router router) {
    router.define(setting, handler: Handler(handlerFunc: (_, __) => SettingPage()));
    router.define(about, handler: Handler(handlerFunc: (_, __) => AboutPage()));
  }
}
