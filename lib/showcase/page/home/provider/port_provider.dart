import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frame_code/frame/net/error_entity.dart';
import 'package:frame_code/frame/util/toast_util.dart';
import 'package:frame_code/showcase/model/air_port_model.dart';
import 'package:frame_code/showcase/services/web_api/web_api.dart';
import 'package:get_it/get_it.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/15
/// 版权： 江苏远大信息股份有限公司

class PortProvider extends ChangeNotifier {
  List<AirPortModel> _list = [];

  List<AirPortModel> get list => _list;

  void loadData(jsonRes) {
    print(jsonRes);
    var data = json.decode(jsonRes)["data"];
    _list.clear();
    for (var item in data){
      _list.add(item == null ? null : AirPortModel(item));
    }
    notifyListeners();
  }

  Future<bool> requestPortInfo(String userGuid) async {
    Map<String,String> params = {
      "useruid": userGuid,
    };
    String data = await GetIt.instance<WebApi>().getPortInfo(params);
    if(data.contains("\"Result\":\"False\"")){
      toastShort(ErrorEntity(data).message);
      return false;
    }else {
      loadData(data);
      return true;
    }
  }




}