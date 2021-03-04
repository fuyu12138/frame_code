import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/15
/// 版权： 江苏远大信息股份有限公司

import 'dart:convert' show json;

class AQIAssessmentModel {

  List<Assessment> assessment;

  AQIAssessmentModel.fromParams({this.assessment});

  factory AQIAssessmentModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? AQIAssessmentModel.fromJson(json.decode(jsonStr)) : AQIAssessmentModel.fromJson(jsonStr);

  AQIAssessmentModel.fromJson(jsonRes) {
    assessment = jsonRes['assessment'] == null ? null : [];

    for (var assessmentItem in assessment == null ? [] : jsonRes['assessment']){
      assessment.add(assessmentItem == null ? null : Assessment.fromJson(assessmentItem));
    }
  }

  @override
  String toString() {
    return '{"assessment": $assessment}';
  }
}

class Assessment {

  String data_time;
  List<Data> data;

  Assessment.fromParams({this.data_time, this.data});

  Assessment.fromJson(jsonRes) {
    data_time = jsonRes['data_time'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : Data.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"data_time": ${data_time != null?'${json.encode(data_time)}':'null'}, "data": $data}';
  }
}

class Data {

  String name;
  String value1;
  String value2;

  Data.fromParams({this.name, this.value1, this.value2});

  Data.fromJson(jsonRes) {
    name = jsonRes['name'];
    value1 = jsonRes['value1'];
    value2 = jsonRes['value2'];
  }

  @override
  String toString() {
    return '{"name": ${name != null?'${json.encode(name)}':'null'}, "value1": ${value1 != null?'${json.encode(value1)}':'null'}, "value2": ${value2 != null?'${json.encode(value2)}':'null'}}';
  }
}