import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:frame_code/frame/net/error_entity.dart';
import 'package:frame_code/frame/util/toast_util.dart';
import 'package:frame_code/showcase/model/real_data_model.dart';
import 'package:frame_code/showcase/services/web_api/web_api.dart';
import 'package:get_it/get_it.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/7
/// 版权： 江苏远大信息股份有限公司

class RealDataProvider extends ChangeNotifier {
  List<RealDataModel> _list = [];

  List<RealDataModel> get list => _list;

  void loadData(jsonRes) {
    print(jsonRes);
    var data = json.decode(jsonRes)["data"];
    print("jsonRes:$data");

    print("data：${data.length}");
    _list.clear();
    for (var item in data){
      _list.add(item == null ? null : RealDataModel(item));
    }
    print("_list：${_list.length}");
    notifyListeners();
  }

  Future<bool> requestRealData(String userGuid) async {
    Map<String,String> params = {
      "useruid": userGuid,
    };
    String data = await GetIt.instance<WebApi>().getRealData(params);
    if(data.contains("\"Result\":\"False\"")){
      toastShort(ErrorEntity(data).message);
      return false;
    }else {
      loadData(data);
      return true;
    }
  }
}