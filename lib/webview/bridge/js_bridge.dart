import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:frame_code/webview/bridge/bridge_Impl.dart';
import 'package:frame_code/webview/bridge/callback.dart';
import 'package:frame_code/webview/bridge/mojs_response_model.dart';
import 'package:frame_code/webview/page/mojs_page.dart';
import 'package:frame_code/webview/page/provider/mojs_provider.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/9
/// 版权： 江苏远大信息股份有限公司

class JSBridge {
  Future<String> callDart(MojsProvider provider, InAppWebViewController controller
      , String uriString) async{
    String methodName = "";
    String apiName = "";
    String param = "{}";
    String port = "";
    if (uriString!=null && uriString != '' && uriString.startsWith('SinoydJSBridge')) {
      Uri uri = Uri.parse(uriString);
      apiName = uri.host;
      param = Uri.decodeComponent(uri.query);
      port = uri.port.toString();
      String path = uri.path;
      if (path!=null && path!= '') {
        methodName = path.replaceAll(new RegExp('/'), '');
      }
    }
    switch(methodName) {
      case 'getConfigValue':
        BridgeImpl.getConfigValue(provider, controller, param, Callback(controller, port));
        break;
      case 'showProgress':
        BridgeImpl.showProgress(provider, controller, param, Callback(controller, port));
        break;
      case 'hideProgress':
        BridgeImpl.hideProgress(provider, controller, param, Callback(controller, port));
        break;
      case 'toast':
        BridgeImpl.toast(provider, controller, param, Callback(controller, port));
        break;
      default :
        Callback(controller, port).apply(getJSONObject(0, methodName + "未注册", null));
        break;
    }
    return '';
  }

  ///Mojs返回数据json
  String getJSONObject(int code, String msg, String result) {
    return MojsResponseModel.fromParams(
        code: code,
        msg: msg,
        result: result == null ? '' : result
    ).toString();
  }


  /// Mojs调用成功返回（不带参数）
  String getSuccessJSONObject() {
    return MojsResponseModel.fromParams(
        code: 1,
        msg: "",
        result: ''
    ).toString();
  }

  /// Mojs调用成功返回（带参数）
  String getSuccessJSONObjectWithResult(String result) {
    return MojsResponseModel.fromParams(
        code: 1,
        msg: "",
        result: result == null ? '' : result
    ).toString();
  }

  /// Mojs调用失败返回
  String getFailJSONObject() {
    return MojsResponseModel.fromParams(
        code: 0,
        msg: "API调用失败",
        result: ''
    ).toString();
  }
}