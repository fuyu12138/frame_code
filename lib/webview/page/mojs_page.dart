import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frame_code/frame/config/app_base_config.dart';
import 'package:frame_code/frame/res/colors.dart';
import 'package:frame_code/webview/bridge/js_bridge.dart';
import 'package:frame_code/webview/page/provider/mojs_provider.dart';
import 'package:provider/provider.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/9
/// 版权： 江苏远大信息股份有限公司

class MojsPage extends StatefulWidget {
  @override
  _MojsPageState createState() => _MojsPageState();
}

class _MojsPageState extends State<MojsPage> with AutomaticKeepAliveClientMixin {
  InAppWebViewController webView;
  String url = "";
  String initUrl = '/page/alarm_info.html?moduletype=air';
  String title = '报警管理';
  double progress = 0;


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MojsProvider>(
        builder: (_, provider, __) {
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(title),
                actions: [
                  IconButton(
                    icon: Icon(Icons.autorenew),
                    onPressed: () {
                      if (webView != null) {
                        webView.reload();
                      }
                    },
                  ),
                ],
              ),
              body: Container(
                  child: Column(children: <Widget>[
                    Container(
                        child: progress < 1.0
                            ? LinearProgressIndicator(value: progress)
                            : Container()),
                    Expanded(
                      child: Stack(
                        children: [
                          InAppWebView(
                            initialUrl: AppBaseConfig.H5Url+initUrl,//'http://192.168.30.191:4444/index.html'
                            initialHeaders: {},
                            initialOptions: InAppWebViewGroupOptions(
                                crossPlatform: InAppWebViewOptions(
                                  debuggingEnabled: true,
                                  userAgent: "Android MOJS/",
                                  javaScriptEnabled: true,
                                )
                            ),
                            onWebViewCreated: (InAppWebViewController controller) {
                              webView = controller;
                            },
                            onLoadStart: (InAppWebViewController controller, String url) {
                              setState(() {
                                this.url = url;
                              });
                            },
                            onLoadStop: (InAppWebViewController controller, String url) async {
                              setState(() {
                                this.url = url;
                              });
                            },
                            onProgressChanged: (InAppWebViewController controller, int progress) {
                              setState(() {
                                this.progress = progress / 100;
                              });
                            },
                            onJsPrompt:(InAppWebViewController controller, JsPromptRequest jsPromptRequest){
                              print("wyf:【mojs调用JsBridge信息:】"+jsPromptRequest.message);
                              JSBridge().callDart(provider, controller, jsPromptRequest.message);
                              return _onJsPrompt();
                            },
                          ),
                          Offstage (
                              offstage: !provider.getLoadingState,
                              child: Container(
                                constraints: BoxConstraints.expand(),
                                color: Colors.black12,
                                child: Center(
                                  child: Opacity(
                                    opacity: 0.9,
                                    child: SpinKitCircle(
                                      color: Colours.color_blue_main,
                                      size: 50.0,
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ])),
            ),
          );
        }
    );
  }

  ///拦截onJsPrompt,取消弹框
  Future<JsPromptResponse> _onJsPrompt ()async {
    return JsPromptResponse(
      handledByClient: true,
    );
  }


  ///拦截onJsPrompt,取消弹框
  Future<JsAlertResponse> _JsAlert ()async {
    return JsAlertResponse(
      handledByClient: false,
    );
  }
}
