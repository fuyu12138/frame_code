
/// 作者： 付雨
/// 创建时间： 2020/9/15
/// 版权： 江苏远大信息股份有限公司

import 'dart:convert' show json;

class AirPortModel {

  String aqi;
  String controlarea;
  String id;
  String isOnline;
  String lat;
  String lon;
  String name;
  String pm25;
  String pm25iaqi;

  AirPortModel.fromParams({this.aqi, this.controlarea, this.id, this.isOnline, this.lat, this.lon, this.name, this.pm25, this.pm25iaqi});

  factory AirPortModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? AirPortModel.fromJson(json.decode(jsonStr)) : AirPortModel.fromJson(jsonStr);

  AirPortModel.fromJson(jsonRes) {
    aqi = jsonRes['aqi'];
    controlarea = jsonRes['controlarea'];
    id = jsonRes['id'];
    isOnline = jsonRes['isOnline'];
    lat = jsonRes['lat'];
    lon = jsonRes['lon'];
    name = jsonRes['name'];
    pm25 = jsonRes['pm25'];
    pm25iaqi = jsonRes['pm25iaqi'];
  }

  @override
  String toString() {
    return '{"aqi": ${aqi != null?'${json.encode(aqi)}':'null'}, "controlarea": ${controlarea != null?'${json.encode(controlarea)}':'null'}, "id": ${id != null?'${json.encode(id)}':'null'}, "isOnline": ${isOnline != null?'${json.encode(isOnline)}':'null'}, "lat": ${lat != null?'${json.encode(lat)}':'null'}, "lon": ${lon != null?'${json.encode(lon)}':'null'}, "name": ${name != null?'${json.encode(name)}':'null'}, "pm25": ${pm25 != null?'${json.encode(pm25)}':'null'}, "pm25iaqi": ${pm25iaqi != null?'${json.encode(pm25iaqi)}':'null'}}';
  }
}