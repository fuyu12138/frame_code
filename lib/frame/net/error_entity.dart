import 'dart:convert' show json;

/// 作者： 付雨
/// 创建时间： 2020/9/6
/// 版权： 江苏远大信息股份有限公司

class ErrorEntity {

  String Result;
  String message;

  ErrorEntity.fromParams({this.Result, this.message});

  factory ErrorEntity(jsonStr) => jsonStr == null ? null : jsonStr is String ? ErrorEntity.fromJson(json.decode(jsonStr)) : ErrorEntity.fromJson(jsonStr);

  ErrorEntity.fromJson(jsonRes) {
    Result = jsonRes['Result'];
    message = jsonRes['message'];
  }

  @override
  String toString() {
    return '{"Result": ${Result != null?'${json.encode(Result)}':'null'}, "message": ${message != null?'${json.encode(message)}':'null'}}';
  }
}