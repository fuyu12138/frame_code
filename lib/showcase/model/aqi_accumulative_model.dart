import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/15
/// 版权： 江苏远大信息股份有限公司

import 'dart:convert' show json;

class AQIAccumulativeModel {

  List<Data> data;

  AQIAccumulativeModel.fromParams({this.data});

  factory AQIAccumulativeModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? AQIAccumulativeModel.fromJson(json.decode(jsonStr)) : AQIAccumulativeModel.fromJson(jsonStr);

  AQIAccumulativeModel.fromJson(jsonRes) {
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : Data.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"data": $data}';
  }
}

class Data {

  DataModel co;
  DataModel days;
  DataModel no2;
  DataModel o3;
  DataModel pm10;
  DataModel pm2d5;
  DataModel so2;

  Data.fromParams({this.co, this.days, this.no2, this.o3, this.pm10, this.pm2d5, this.so2});

  Data.fromJson(jsonRes) {
    co = jsonRes['co'] == null ? null : DataModel.fromJson(jsonRes['co']);
    days = jsonRes['days'] == null ? null : DataModel.fromJson(jsonRes['days']);
    no2 = jsonRes['no2'] == null ? null : DataModel.fromJson(jsonRes['no2']);
    o3 = jsonRes['o3'] == null ? null : DataModel.fromJson(jsonRes['o3']);
    pm10 = jsonRes['pm10'] == null ? null : DataModel.fromJson(jsonRes['pm10']);
    pm2d5 = jsonRes['pm2d5'] == null ? null : DataModel.fromJson(jsonRes['pm2d5']);
    so2 = jsonRes['so2'] == null ? null : DataModel.fromJson(jsonRes['so2']);
  }

  @override
  String toString() {
    return '{"co": $co, "days": $days, "no2": $no2, "o3": $o3, "pm10": $pm10, "pm2d5": $pm2d5, "so2": $so2}';
  }
}

class DataModel {

  String increase;
  String increasechain;
  String value;

  DataModel.fromParams({this.increase, this.increasechain, this.value});

  DataModel.fromJson(jsonRes) {
    increase = jsonRes['increase'];
    increasechain = jsonRes['increasechain'];
    value = jsonRes['value'];
  }

  @override
  String toString() {
    return '{"increase": ${increase != null?'${json.encode(increase)}':'null'}, "increasechain": ${increasechain != null?'${json.encode(increasechain)}':'null'}, "value": ${value != null?'${json.encode(value)}':'null'}}';
  }
}