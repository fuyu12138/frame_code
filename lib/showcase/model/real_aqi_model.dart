import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/15
/// 版权： 江苏远大信息股份有限公司

import 'dart:convert' show json;

class RealAQIModel {

  String aqi;
  String time;
  List<FactorModel> factorValues;
  List<FactorModel> mainPollutes;

  RealAQIModel.fromParams({this.aqi, this.time, this.factorValues, this.mainPollutes});

  factory RealAQIModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? RealAQIModel.fromJson(json.decode(jsonStr)) : RealAQIModel.fromJson(jsonStr);

  RealAQIModel.fromJson(jsonRes) {
    aqi = jsonRes['aqi'];
    time = jsonRes['time'];
    factorValues = jsonRes['factorValues'] == null ? null : [];

    for (var factorValuesItem in factorValues == null ? [] : jsonRes['factorValues']){
      factorValues.add(factorValuesItem == null ? null : FactorModel.fromJson(factorValuesItem));
    }

    mainPollutes = jsonRes['mainPollutes'] == null ? null : [];

    for (var mainPollutesItem in mainPollutes == null ? [] : jsonRes['mainPollutes']){
      mainPollutes.add(mainPollutesItem == null ? null : FactorModel.fromJson(mainPollutesItem));
    }
  }

  @override
  String toString() {
    return '{"aqi": ${aqi != null?'${json.encode(aqi)}':'null'}, "time": ${time != null?'${json.encode(time)}':'null'}, "factorValues": $factorValues, "mainPollutes": $mainPollutes}';
  }
}

class FactorModel {

  String factor;
  String maxvalue;
  String unit;
  String value;

  FactorModel.fromParams({this.factor, this.maxvalue, this.unit, this.value});

  FactorModel.fromJson(jsonRes) {
    factor = jsonRes['factor'];
    maxvalue = jsonRes['maxvalue'];
    unit = jsonRes['unit'];
    value = jsonRes['value'];
  }

  @override
  String toString() {
    return '{"factor": ${factor != null?'${json.encode(factor)}':'null'}, "maxvalue": ${maxvalue != null?'${json.encode(maxvalue)}':'null'}, "unit": ${unit != null?'${json.encode(unit)}':'null'}, "value": ${value != null?'${json.encode(value)}':'null'}}';
  }
}