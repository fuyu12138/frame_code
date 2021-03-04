import 'package:flutter/material.dart';
import 'package:frame_code/frame/config/frm_keys_config.dart';
import 'package:frame_code/frame/router/fluro_navigation.dart';
import 'package:frame_code/frame/util/change_notifier_manage.dart';
import 'package:frame_code/frame/util/image_utils.dart';
import 'package:frame_code/frame/util/sp_util.dart';
import 'package:frame_code/frame/util/toast_util.dart';
import 'package:frame_code/frame/widgets/load_image.dart';
import 'package:frame_code/showcase/model/user_model.dart';
import 'package:frame_code/showcase/page/login/login_router.dart';
import 'package:frame_code/showcase/page/login/widgets/my_text_field.dart';
import 'package:frame_code/showcase/provider/user_provider.dart';
import 'package:frame_code/showcase/router/routers.dart';
import 'package:provider/provider.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ChangeNotifierMixin<LoginPage>{

  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _userNameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    final List<VoidCallback> callbacks = [_verify];
    return {
      _userNameTextController: callbacks,
      _passwordTextController: callbacks,
      _userNameFocus: null,
      _passwordFocus: null,
    };
  }

  void _verify() {
    final String name = _userNameTextController.text;
    final String  password = _passwordTextController.text;
    bool clickable = true;
    if (name.isEmpty || password.isEmpty) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    _userNameTextController.text = "admin";
    _passwordTextController.text = "sz2017!";
    return Material(
      child: Stack(
        children: [
          LoadAssetImage("login/bg",
            format: ImageFormat.jpg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50,0,50,0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 2),
                  LoadAssetImage("login/logo", width: 80,),
                  Padding(
                    padding: EdgeInsets.only(top:30.0),
                  ),
                  Text(
                    "环境质量",
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Spacer(flex: 1),
                  Padding(
                    padding: EdgeInsets.only(top:50.0),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: MyTextField(
                          hintText: '用户名',
                          textInputAction: TextInputAction.next,
                          focusNode: _userNameFocus,
                          controller: _userNameTextController,
                          onEditingComplete: (){
                            _userNameFocus.nextFocus();
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:25.0),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: MyTextField(
                            hintText: '密 码',
                            focusNode: _passwordFocus,
                            textInputAction: TextInputAction.go,
                            controller: _passwordTextController,
                            isPwd: true,
                            onEditingComplete: (){
                              _passwordFocus.unfocus();
                            },
                          )
                      ),
                    ],
                  )
                  ,
                  Padding(
                    padding: EdgeInsets.only(top:50.0),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                          onPressed: _clickable ? () async {
                            bool result = await Provider.of<UserProvider>(context,listen: false).login(_userNameTextController.text, _passwordTextController.text);
                            if(result){
                              SpUtil.putString(FrmKeysConfig.UserGuid, Provider.of<UserProvider>(context,listen: false).userGuid);
                              NavigatorUtils.push(context, Routers.main, replace: true);
                            }
                          } : null,
                          child: Text(
                            '登 录',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.0),
                          ),
                          color: Color(0xFF0b9ff2),
                          disabledColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                    ),
                  Spacer(flex: 6),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
