import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:frame_code/frame/util/sp_util.dart';
import 'package:frame_code/frame/util/toast_util.dart';
import 'package:frame_code/webview/bridge/callback.dart';
import 'package:frame_code/webview/bridge/js_bridge.dart';
import 'package:frame_code/webview/page/provider/mojs_provider.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/9
/// 版权： 江苏远大信息股份有限公司

class BridgeImpl {

  /// 获取本地存储值
  static void getConfigValue(MojsProvider provider, InAppWebViewController controller, String param, Callback callback) {
    try{
      String key = json.decode(param)["config_key"];
      String result = '{"value":"${SpUtil.getString(key, defValue: '')}"}';
      callback.apply(JSBridge().getSuccessJSONObjectWithResult(result));
    }catch(e) {
      print("mojs错误:$e");
      callback.apply(JSBridge().getFailJSONObject());
    }
  }

  static void showProgress(MojsProvider provider, InAppWebViewController controller, String param, Callback callback) {
    try{
      provider.showLoading(true);
      callback.apply(JSBridge().getSuccessJSONObject());
    }catch(e) {
      print("mojs错误:$e");
      callback.apply(JSBridge().getFailJSONObject());
    }
  }
  static void hideProgress(MojsProvider provider, InAppWebViewController controller, String param, Callback callback) {
    try{
      provider.showLoading(false);
      callback.apply(JSBridge().getSuccessJSONObject());
    }catch(e) {
      print("mojs错误:$e");
      callback.apply(JSBridge().getFailJSONObject());
    }
  }

  static void toast(MojsProvider provider, InAppWebViewController controller, String param, Callback callback) {
    try {
      toastShort('toast');
      callback.apply(JSBridge().getSuccessJSONObject());
    } catch (e) {
      print("mojs错误:$e");
      callback.apply(JSBridge().getFailJSONObject());
    }
  }
}