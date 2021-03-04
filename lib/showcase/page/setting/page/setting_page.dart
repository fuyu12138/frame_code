
import 'package:flutter/material.dart';
import 'package:frame_code/frame/config/frm_keys_config.dart';
import 'package:frame_code/frame/provider/theme_provider.dart';
import 'package:frame_code/frame/res/colors.dart';
import 'package:frame_code/frame/router/fluro_navigation.dart';
import 'package:frame_code/frame/util/sp_util.dart';
import 'package:frame_code/frame/util/toast_util.dart';
import 'package:frame_code/showcase/page/login/page/login_page.dart';
import 'package:frame_code/showcase/page/setting/provider/app_version_provider.dart';
import 'package:frame_code/showcase/page/setting/setting_router.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<String> _list = ['偏好站点设置', '使用帮助', '检查更新',"关于"];
  final List<String> _themeList = ['跟随系统','深色调', '浅色调'];

  String version = '';

  String groupValue = "跟随系统";

  getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      if(mounted) {
        version = packageInfo.version;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getVersionInfo();
  }

  @override
  Widget build(BuildContext context) {

    Provider.of<AppVersionProvider>(context, listen: false).getAppVersion();

    String theme = SpUtil.getString(FrmKeysConfig.AppTheme);
    switch(theme) {
      case 'Dark':
        groupValue = _themeList[1];
        break;
      case 'Light':
        groupValue = _themeList[2];
        break;
      default:
        groupValue = _themeList[0];
        break;
    }
    return Theme(
        data: ThemeProvider().getTheme(),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            elevation: 4,
            title:Text(
              "设置",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle:true,
          ),
          body: Consumer<AppVersionProvider>(
            builder: (context, provider, child) {
              return Container(
                width: double.infinity,
                color: Color(0xffefefef),
                child: Column(
                  children:[
                    SizedBox(height: 20),
                    _item(_list[0],'',() {
                      changeThemeMode();
                    }),
                    _item(_list[1],'',() {toastShort(_list[1]);}),
                    SizedBox(height: 20),
                    _item(_list[2],provider.versionInfo == null ?
                      '' : provider.versionInfo.verName,
                      () {
                        if(provider.versionInfo!=null &&provider.versionInfo.verPath!=null){
                          int index = provider.versionInfo.verPath.lastIndexOf('/');
                          install(provider.versionInfo.verPath, provider.versionInfo.verPath.substring(index+1));
                        }else{
                          toastShort('获取版本信息失败');
                        }
                        //todo 请求版本信息，如果有则弹窗
                      }
                    ),
                    _item(_list[3], version == '' ? '' : '版本号 $version',() {
                      NavigatorUtils.push(context, SettingRouter.about);
                    }),
                    GestureDetector(
                      child: _logOff(),
                      onTap: () {
                        SpUtil.putString(FrmKeysConfig.UserGuid,'');

                        SpUtil.putString(FrmKeysConfig.UserName,'');
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
                          ModalRoute.withName('/login'),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          )
        )
    );
  }

  Widget _item(String text,String rightText, Function onTap){
    return Container(
      margin: EdgeInsets.only(bottom: 1),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
            // ThemeMode themeMode = index == 0 ? ThemeMode.system : (index == 1 ? ThemeMode.dark : ThemeMode.light);
            // context.read<ThemeProvider>().setTheme(themeMode);
          child: Container(
            alignment: Alignment.centerLeft,
            height: 50.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Center(
                              child: Text(
                                text,
                              )
                          ),
                        ),
                        Spacer(flex: 1,),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Center(
                              child: Text(
                                rightText,
                              )
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logOff() {
    return Container(
      height: 50,
      margin: EdgeInsets.all(20),
      child: Card(
        color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            '退出登录',
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ),
      ),
    );
  }

  /// 深色模式选择
  Future<void> changeThemeMode() async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

            actions: [
              FlatButton(
                  child: Text("关闭"),
                  onPressed: () => Navigator.pop(context)),
            ],
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    title: Text(_themeList[0]),
                    value: _themeList[0],
                    activeColor: Colours.color_blue_main,
                    onChanged: (value) {
                      context.read<ThemeProvider>().setTheme(ThemeMode.system);
                      setState(() {
                        groupValue = value;
                      });
                    },
                    groupValue: groupValue,
                  ),
                  RadioListTile(
                    title: Text(_themeList[2]),
                    value: _themeList[2],
                    activeColor: Colours.color_blue_main,
                    onChanged: (value) {
                      context.read<ThemeProvider>().setTheme(ThemeMode.light);
                      setState(() {
                        groupValue = value;
                      });
                    },
                    groupValue: groupValue,
                  ),
                  RadioListTile(
                    title: Text(_themeList[1]),
                    value: _themeList[1],
                    activeColor: Colours.color_blue_main,
                    onChanged: (value) {
                      context.read<ThemeProvider>().setTheme(ThemeMode.dark);
                      setState(() {
                        groupValue = value;
                      });
                    },
                    groupValue: groupValue,
                  ),
                ],
              ),
            ),

          );
        });

    if (i != null) {
      print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
    }
  }

  /// 自动更新
  Future<bool> install(String url, String fileName) async {
    //检查存储权限
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.

    }
  }
}
