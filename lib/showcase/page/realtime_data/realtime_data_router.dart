import 'package:fluro/fluro.dart' as Fluro;
import 'package:frame_code/frame/router/i_router.dart';
import 'package:frame_code/showcase/page/realtime_data/page/realtime_data_page.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司

class RealTimeDataRouter implements IRouterProvider {

  static String realData = "/realData";


  @override
  void initRouter(Fluro.Router router) {
    router.define(realData, handler: Fluro.Handler(handlerFunc: (_, __) => RealTimeDataPage()));
  }
}
