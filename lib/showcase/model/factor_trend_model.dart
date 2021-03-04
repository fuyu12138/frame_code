import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/15
/// 版权： 江苏远大信息股份有限公司

import 'dart:convert' show json;

class FactorTrendModel {

  String factorname;
  String maxvalue;
  String unit;
  List<MonitorDataModel> monitorDatas;

  FactorTrendModel.fromParams({this.factorname, this.maxvalue, this.unit, this.monitorDatas});

  factory FactorTrendModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? FactorTrendModel.fromJson(json.decode(jsonStr)) : FactorTrendModel.fromJson(jsonStr);

  FactorTrendModel.fromJson(jsonRes) {
    factorname = jsonRes['factorname'];
    maxvalue = jsonRes['maxvalue'];
    unit = jsonRes['unit'];
    monitorDatas = jsonRes['monitorDatas'] == null ? null : [];

    for (var monitorDatasItem in monitorDatas == null ? [] : jsonRes['monitorDatas']){
      monitorDatas.add(monitorDatasItem == null ? null : MonitorDataModel.fromJson(monitorDatasItem));
    }
  }

  @override
  String toString() {
    return '{"factorname": ${factorname != null?'${json.encode(factorname)}':'null'}, "maxvalue": ${maxvalue != null?'${json.encode(maxvalue)}':'null'}, "unit": ${unit != null?'${json.encode(unit)}':'null'}, "monitorDatas": $monitorDatas}';
  }
}

class MonitorDataModel {

  String color;
  String data_time;
  String value;

  MonitorDataModel.fromParams({this.color, this.data_time, this.value});

  MonitorDataModel.fromJson(jsonRes) {
    color = jsonRes['color'];
    data_time = jsonRes['data_time'];
    value = jsonRes['value'];
  }

  @override
  String toString() {
    return '{"color": ${color != null?'${json.encode(color)}':'null'}, "data_time": ${data_time != null?'${json.encode(data_time)}':'null'}, "value": ${value != null?'${json.encode(value)}':'null'}}';
  }
}