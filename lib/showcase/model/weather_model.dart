import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/15
/// 版权： 江苏远大信息股份有限公司

import 'dart:convert' show json;

class WeatherModel {

  String cloud;
  String cond_code;
  String cond_txt;
  String fl;
  String hum;
  String pcpn;
  String pres;
  String tmp;
  String vis;
  String wind_deg;
  String wind_dir;
  String wind_sc;
  String wind_spd;

  WeatherModel.fromParams({this.cloud, this.cond_code, this.cond_txt, this.fl, this.hum, this.pcpn, this.pres, this.tmp, this.vis, this.wind_deg, this.wind_dir, this.wind_sc, this.wind_spd});

  factory WeatherModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? WeatherModel.fromJson(json.decode(jsonStr)) : WeatherModel.fromJson(jsonStr);

  WeatherModel.fromJson(jsonRes) {
    cloud = jsonRes['cloud'];
    cond_code = jsonRes['cond_code'];
    cond_txt = jsonRes['cond_txt'];
    fl = jsonRes['fl'];
    hum = jsonRes['hum'];
    pcpn = jsonRes['pcpn'];
    pres = jsonRes['pres'];
    tmp = jsonRes['tmp'];
    vis = jsonRes['vis'];
    wind_deg = jsonRes['wind_deg'];
    wind_dir = jsonRes['wind_dir'];
    wind_sc = jsonRes['wind_sc'];
    wind_spd = jsonRes['wind_spd'];
  }

  @override
  String toString() {
    return '{"cloud": ${cloud != null?'${json.encode(cloud)}':'null'}, "cond_code": ${cond_code != null?'${json.encode(cond_code)}':'null'}, "cond_txt": ${cond_txt != null?'${json.encode(cond_txt)}':'null'}, "fl": ${fl != null?'${json.encode(fl)}':'null'}, "hum": ${hum != null?'${json.encode(hum)}':'null'}, "pcpn": ${pcpn != null?'${json.encode(pcpn)}':'null'}, "pres": ${pres != null?'${json.encode(pres)}':'null'}, "tmp": ${tmp != null?'${json.encode(tmp)}':'null'}, "vis": ${vis != null?'${json.encode(vis)}':'null'}, "wind_deg": ${wind_deg != null?'${json.encode(wind_deg)}':'null'}, "wind_dir": ${wind_dir != null?'${json.encode(wind_dir)}':'null'}, "wind_sc": ${wind_sc != null?'${json.encode(wind_sc)}':'null'}, "wind_spd": ${wind_spd != null?'${json.encode(wind_spd)}':'null'}}';
  }
}