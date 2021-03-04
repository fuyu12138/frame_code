import 'dart:convert' show json;

/// 作者： 付雨
/// 创建时间： 2020/9/5
/// 版权： 江苏远大信息股份有限公司

class BaseEntity {
  int code;
  String data;

  BaseEntity.fromParams(this.code, this.data);

  factory BaseEntity(jsonStr) => jsonStr == null ? null : jsonStr is String ? BaseEntity.fromJson(json.decode(jsonStr)) : BaseEntity.fromJson(jsonStr);

  BaseEntity.fromJson(jsonRes) {
    code = jsonRes['code'];
    data = jsonRes['data'];
  }

  @override
  String toString() {
    return '{"code": $code, "data": ${data != null?'${json.encode(data)}':'null'}}';
  }
}
