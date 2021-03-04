import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frame_code/frame/config/app_base_config.dart';
import 'package:frame_code/frame/net/http_api.dart';
import 'package:frame_code/frame/net/http_method.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/5
/// 版权： 江苏远大信息股份有限公司

class DioManager {
  static final DioManager _shared = DioManager._internal();
  factory DioManager() => _shared;
  Dio dio;
  DioManager._internal() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: AppBaseConfig.defaultUrl,
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.plain,
        receiveDataWhenStatusError: false,
        connectTimeout: 30000,
        receiveTimeout: 3000,
      );
      dio = Dio(options);
    }
  }

  // method：请求方法
  // url：请求地址
  // params：请求参数
  Future<String> request(HttpMethod method, String url, {Map params, FormData data}) async {
    try {
      print("[请求地址]：$url");
      Response response;
      if(method == HttpMethod.GET){
        response = await dio.request(url, queryParameters:params, options: Options(method: MethodValues[method]));
      }else if(method == HttpMethod.POST){
        response = await dio.request(url, data:FormData.fromMap(params), options: Options(method: MethodValues[method]));
      }
      if (response != null) {
        if(response.statusCode >=200 && response.statusCode<300) {
          return convert(response.statusCode, response.data);
        }else {
          return convert(response.statusCode, response.data);
        }
      } else {
        return convert(-1, null);
      }
    } on DioError catch(e) {
      print("error:${e.message}");
      return convert(-1, null);
    }
  }

  String convert(int code, data) {
    String content = json.encode(data.toString());
    print('[返回结果]{"code": $code, "data": ${data != null?content:"null"}}');
    return '{"code": $code, "data": ${data != null? content:"null"}}';
  }
}