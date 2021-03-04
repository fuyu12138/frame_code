import 'dart:convert' show json;

/// 作者： 付雨
/// 创建时间： 2020/9/10
/// 版权： 江苏远大信息股份有限公司

class MojsResponseModel {

  int code;
  String msg;
  String result;

  MojsResponseModel.fromParams({this.code, this.msg, this.result});

  factory MojsResponseModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? MojsResponseModel.fromJson(json.decode(jsonStr)) : MojsResponseModel.fromJson(jsonStr);

  MojsResponseModel.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    result = jsonRes['result'];
  }

  @override
  String toString() {
    return '{"code": $code, "msg": ${msg != null?'${json.encode(msg)}':'null'}, "result": ${result != null?'$result':''}}';
  }
}