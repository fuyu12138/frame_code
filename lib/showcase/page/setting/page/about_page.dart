import 'package:flutter/material.dart';
import 'package:frame_code/frame/util/image_utils.dart';
import 'package:frame_code/frame/util/toast_util.dart';
import 'package:frame_code/frame/widgets/load_image.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/9
/// 版权： 江苏远大信息股份有限公司

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final List<String> _list = ['新版本介绍','售后电话：400-1188-1228', '客服邮箱：sinoyd@sinoyd.com', "公司简介"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 4,
        title:Text(
          "关于",
          style: TextStyle(
              fontSize: 18,
              color: Colors.white
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle:true,
      ),
      body: Container(
        color: Color(0xffefefef),
        child: Stack(
          children: [
            Column(
              children: [
                Spacer(
                  flex: 1,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Text(
                      'Copyright by 江苏远大信息',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(bottom: 56),
              child: Container(
                height: 180,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    LoadAssetImage('login/logo', width: 80),
                    SizedBox(height: 20,),
                    Container(
                      child: Center(
                        child: Text(
                          '环境质量Android客户端'
                        )
                      )
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          '版本号 1.0.0'
                        )
                      )
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      color: Color(0xffefefef),
                      child: Column(
                        children:[
                          _item(_list[0],'',() {toastShort(_list[0]);}),
                          _item(_list[1],'',() {toastShort(_list[1]);}),
                          _item(_list[2],'',() {toastShort(_list[2]);}),
                          _item(_list[3],'',() {toastShort(_list[3]);}),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    QrImage(
                      data: "1234567890",
                      version: QrVersions.auto,
                      size: 150.0,
                      // embeddedImage: AssetImage('${ImageUtils.getImgPath('login/logo')}'),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                          '扫描二维码，下载环境质量APP！'
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
}
