
import 'package:flutter/material.dart';
import 'package:frame_code/frame/res/colors.dart';
import 'package:frame_code/frame/res/dimens.dart';
import 'package:frame_code/frame/util/double_tap_back_exit_app.dart';
import 'package:frame_code/frame/widgets/load_image.dart';
import 'package:frame_code/showcase/page/demo/page/demo_page.dart';
import 'package:frame_code/showcase/page/gis/page/gis_page.dart';
import 'package:frame_code/showcase/page/gis/provider/gis_page_provider.dart';
import 'package:frame_code/showcase/page/home/page/home_page.dart';
import 'package:frame_code/showcase/page/main/provider/home_provider.dart';
import 'package:frame_code/showcase/page/realtime_data/page/realtime_data_page.dart';
import 'package:frame_code/showcase/page/realtime_data/provider/real_data_provider.dart';
import 'package:frame_code/showcase/page/setting/page/setting_page.dart';
import 'package:frame_code/showcase/page/setting/provider/app_version_provider.dart';
import 'package:frame_code/webview/page/mojs_page.dart';
import 'package:frame_code/webview/page/provider/mojs_provider.dart';
import 'package:provider/provider.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  static const double _imageSize = 25.0;

  HomeProvider provider = HomeProvider();
  List<Widget> _pageList;
  final List<String> _appBarTitles = ['首页','实时数据','GIS','报警管理','设置'];

  List<BottomNavigationBarItem> _barItemList;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData(){
    _pageList = [
      HomePage(),
      RealTimeDataPage(),
      GISPage(),
      MojsPage(),
      SettingPage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationItem() {
    if(_barItemList == null) {
      var _tabImages = const [
        [
          LoadAssetImage("home/tabicon_home",width: _imageSize,),
          LoadAssetImage("home/tabicon_home_select",width: _imageSize,),
        ],
        [
          LoadAssetImage("home/tabicon_realtime",width: _imageSize,),
          LoadAssetImage("home/tabicon_realtime_select",width: _imageSize,),
        ],
        [
          LoadAssetImage("home/tabicon_gis",width: _imageSize,),
          LoadAssetImage("home/tabicon_gis_select",width: _imageSize,),
        ],
        [
          LoadAssetImage("home/tabicon_alarm",width: _imageSize,),
          LoadAssetImage("home/tabicon_alarm_select",width: _imageSize,),
        ],
        [
          LoadAssetImage("home/tabicon_about",width: _imageSize,),
          LoadAssetImage("home/tabicon_about_select",width: _imageSize,),
        ],
      ];
      _barItemList = List.generate(_tabImages.length, (index) =>
        BottomNavigationBarItem(
          icon: _tabImages[index][0],
          activeIcon: _tabImages[index][1],
          title: Text(_appBarTitles[index], key: Key(_appBarTitles[index]),),
        )
      );
    }
    return _barItemList;
  }


  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeProvider()),
          ChangeNotifierProvider(create: (_) => RealDataProvider()),
          ChangeNotifierProvider(create: (_) => AppVersionProvider()),
          ChangeNotifierProvider(create: (_) => MojsProvider()),
          ChangeNotifierProvider(create: (_) => GISPageProvider()),
        ],
        child: Consumer<HomeProvider>(
            builder: (BuildContext context, provider, __) {
              return DoubleTapBackExitApp(
                  child: Scaffold(
                    bottomNavigationBar: Theme(
                      data: ThemeData(//隐藏水波纹效果
                        brightness: Brightness.light,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: BottomNavigationBar(
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        items: _buildBottomNavigationItem(),
                        type: BottomNavigationBarType.fixed,
                        currentIndex: provider.index,
                        elevation: 4.0,
                        iconSize: 21.0,
                        selectedFontSize: Dimens.font_sp10,
                        unselectedFontSize: Dimens.font_sp10,
                        selectedItemColor: Theme.of(context).primaryColor,
                        unselectedItemColor: isDark ? Colours.dark_unselected_item_color : Colours.unselected_item_color,
                        onTap: (index) => provider.index = index,
                      ),
                    ),
                    body: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      pageSnapping: true,
                      controller: Provider.of<HomeProvider>(context,listen: false).pageController,
                      // onPageChanged: (int index) => provider.value = index,
                      children: _pageList,
                    ),
                  )
              );
            }
        )
    );
  }
}
