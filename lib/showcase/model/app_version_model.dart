import 'dart:convert' show json;

/// 作者： 付雨
/// 创建时间： 2020/9/9
/// 版权： 江苏远大信息股份有限公司

class AppVersionModel {

  String verCode;
  String verDesc;
  String verName;
  String verPath;

  AppVersionModel.fromParams({this.verCode, this.verDesc, this.verName, this.verPath});

  factory AppVersionModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? AppVersionModel.fromJson(json.decode(jsonStr)) : AppVersionModel.fromJson(jsonStr);

  AppVersionModel.fromJson(jsonRes) {
    verCode = jsonRes['verCode'];
    verDesc = jsonRes['verDesc'];
    verName = jsonRes['verName'];
    verPath = jsonRes['verPath'];
  }

  @override
  String toString() {
    return '{"verCode": ${verCode != null?'${json.encode(verCode)}':'null'}, "verDesc": ${verDesc != null?'${json.encode(verDesc)}':'null'}, "verName": ${verName != null?'${json.encode(verName)}':'null'}, "verPath": ${verPath != null?'${json.encode(verPath)}':'null'}}';
  }
}