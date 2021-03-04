import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/15
/// 版权： 江苏远大信息股份有限公司

import 'dart:convert' show json;

class FineDaysModel {

  DaysDetailModel daysDetail;
  MainInfoModel mainInfo;

  FineDaysModel.fromParams({this.daysDetail, this.mainInfo});

  factory FineDaysModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? FineDaysModel.fromJson(json.decode(jsonStr)) : FineDaysModel.fromJson(jsonStr);

  FineDaysModel.fromJson(jsonRes) {
    daysDetail = jsonRes['daysDetail'] == null ? null : DaysDetailModel.fromJson(jsonRes['daysDetail']);
    mainInfo = jsonRes['mainInfo'] == null ? null : MainInfoModel.fromJson(jsonRes['mainInfo']);
  }

  @override
  String toString() {
    return '{"daysDetail": $daysDetail, "mainInfo": $mainInfo}';
  }
}

class MainInfoModel {

  String days_increase;
  String days_increasechain;
  String days_total;
  String maxtime;

  MainInfoModel.fromParams({this.days_increase, this.days_increasechain, this.days_total, this.maxtime});

  MainInfoModel.fromJson(jsonRes) {
    days_increase = jsonRes['days_increase'];
    days_increasechain = jsonRes['days_increasechain'];
    days_total = jsonRes['days_total'];
    maxtime = jsonRes['maxtime'];
  }

  @override
  String toString() {
    return '{"days_increase": ${days_increase != null?'${json.encode(days_increase)}':'null'}, "days_increasechain": ${days_increasechain != null?'${json.encode(days_increasechain)}':'null'}, "days_total": ${days_total != null?'${json.encode(days_total)}':'null'}, "maxtime": ${maxtime != null?'${json.encode(maxtime)}':'null'}}';
  }
}

class DaysDetailModel {

  String days1;
  String days2;
  String days3;
  String days4;
  String days5;
  String days6;

  DaysDetailModel.fromParams({this.days1, this.days2, this.days3, this.days4, this.days5, this.days6});

  DaysDetailModel.fromJson(jsonRes) {
    days1 = jsonRes['days1'];
    days2 = jsonRes['days2'];
    days3 = jsonRes['days3'];
    days4 = jsonRes['days4'];
    days5 = jsonRes['days5'];
    days6 = jsonRes['days6'];
  }

  @override
  String toString() {
    return '{"days1": ${days1 != null?'${json.encode(days1)}':'null'}, "days2": ${days2 != null?'${json.encode(days2)}':'null'}, "days3": ${days3 != null?'${json.encode(days3)}':'null'}, "days4": ${days4 != null?'${json.encode(days4)}':'null'}, "days5": ${days5 != null?'${json.encode(days5)}':'null'}, "days6": ${days6 != null?'${json.encode(days6)}':'null'}}';
  }
}