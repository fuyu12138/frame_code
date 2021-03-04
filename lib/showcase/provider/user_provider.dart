import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frame_code/frame/net/error_entity.dart';
import 'package:frame_code/frame/util/toast_util.dart';
import 'package:frame_code/showcase/model/user_model.dart';
import 'package:frame_code/showcase/services/service_locator.dart';
import 'package:frame_code/showcase/services/web_api/web_api.dart';
import 'package:frame_code/showcase/services/web_api/web_api_impl.dart';
import 'package:get_it/get_it.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/5
/// 版权： 江苏远大信息股份有限公司

class UserProvider extends ChangeNotifier {
  UserModel user;

  bool isLogin = false;

  String get userName => user == null ? "" : user.username ?? "";

  String get userGuid => user == null ? "" : user.userguid ?? "";

  bool get getLoginState => isLogin;

  void setUser(jsonRes) {
    user = UserModel(jsonRes);
    isLogin = true;
    notifyListeners();
  }

 Future<bool> login(String loginId, String password) async {
    Map<String,String> params = {
      "LoginId":loginId,
      "Password": password,
    };
    String data = await GetIt.instance<WebApi>().login(params);
    if(data.contains("\"Result\":\"False\"")){
      toastShort(ErrorEntity(data).message);
      return false;
    }else {
      setUser(data.substring(1,data.length-1));
      return true;
    }
 }
}