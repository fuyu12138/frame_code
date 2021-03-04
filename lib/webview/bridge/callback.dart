import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/9
/// 版权： 江苏远大信息股份有限公司

class Callback {
  static final String callBackJsFormat = "javascript:JSBridge._handleMessageFromNative";
  String _port;
  InAppWebViewController _controller;

  Callback(InAppWebViewController controller, String port) {
    this._port = port;
    this._controller = controller;
  }

  void apply(String jsonObj) async {
    String response = '$callBackJsFormat({"responseId":"$_port","responseData":$jsonObj});';
    print("wyf:【mojs返回JsBridge信息:】$response");
    if(_controller !=null ) {
      // _controller.loadUrl(url: response);
      _controller.evaluateJavascript(source: response);
    }
  }
}