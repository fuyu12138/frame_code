import 'package:flutter/material.dart';
import 'package:frame_code/frame/net/error_entity.dart';
import 'package:frame_code/frame/util/toast_util.dart';
import 'package:frame_code/showcase/model/app_version_model.dart';
import 'dart:convert' show json;

import 'package:frame_code/showcase/services/web_api/web_api.dart';
import 'package:get_it/get_it.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/9
/// 版权： 江苏远大信息股份有限公司

class AppVersionProvider extends ChangeNotifier {
  AppVersionModel _info;

  AppVersionModel get versionInfo => _info;

  void loadData(jsonRes) {
    var version = json.decode(jsonRes)["Version"];
    _info = AppVersionModel(version);
    notifyListeners();
  }

  Future<bool> getAppVersion() async {
    Map<String, String> params = {};
    String data = await GetIt.instance<WebApi>().getAppVersion(params);
    if (data.contains("\"Result\":\"False\"")) {
      toastShort(ErrorEntity(data).message);
      return false;
    } else {
      loadData(data);
      return true;
    }
  }
}