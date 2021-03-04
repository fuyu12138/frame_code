import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frame_code/frame/page/base_page.dart';
import 'package:frame_code/frame/util/device_util.dart';
import 'package:frame_code/showcase/model/user_model.dart';
import 'package:frame_code/showcase/page/main/main_page.dart';
import 'package:frame_code/showcase/page/main/welcome_page.dart';
import 'package:frame_code/showcase/page/login/page/login_page.dart';
import 'package:frame_code/showcase/page/setting/provider/app_version_provider.dart';
import 'package:frame_code/showcase/provider/user_provider.dart';
import 'package:frame_code/showcase/router/routers.dart';
import 'package:frame_code/showcase/services/service_locator.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';

import 'frame/provider/theme_provider.dart';
import 'frame/util/sp_util.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // sp初始化
  await SpUtil.getInstance();
  setupServiceLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    )
  );
  if (Device.isAndroid) {//透明状态栏
    final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  // 百度地图初始化
  // if(Device.isIOS){
  //   BMFMapSDK.setApiKeyAndCoordType(
  //       '请输入百度开放平台申请的iOS端API KEY', BMF_COORD_TYPE.BD09LL);
  // }else if(Device.isAndroid){
  //   BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  // }
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  MyApp({this.theme}) {
    Routers.initRouters();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
          builder: (_, provider, __){
            return MaterialApp(
              title: "frame demo",
              theme: theme ?? provider.getTheme(),
              darkTheme: provider.getTheme(isDarkMode: true),
              themeMode: provider.getThemeMode(),
              home: LoginPage(),
            );
          }
    );
  }
}