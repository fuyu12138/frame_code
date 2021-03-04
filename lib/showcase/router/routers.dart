
import 'package:fluro/fluro.dart' as Fluro;
import 'package:flutter/widgets.dart';
import 'package:frame_code/frame/router/i_router.dart';
import 'package:frame_code/showcase/page/gis/gis_router.dart';
import 'package:frame_code/showcase/page/login/login_router.dart';
import 'package:frame_code/showcase/page/main/main_page.dart';
import 'package:frame_code/showcase/page/main/welcome_page.dart';
import 'package:frame_code/showcase/page/realtime_data/realtime_data_router.dart';
import 'package:frame_code/showcase/page/setting/setting_router.dart';



class Routers{

  static String main = "/main";

  static final List<IRouterProvider> _listRouter = [];
  static final Fluro.Router router = Fluro.Router();

  static void initRouters() {
    router.notFoundHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        debugPrint('未找到目标页');
        return WelcomePage();
      });

    router.define(main, handler: Fluro.Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) => MainPage()));

    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(RealTimeDataRouter());
    _listRouter.add(GisRouter());
    _listRouter.add(SettingRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}