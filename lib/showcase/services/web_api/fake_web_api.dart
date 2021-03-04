import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frame_code/showcase/model/user_model.dart';
import 'package:frame_code/showcase/services/web_api/web_api.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/5
/// 版权： 江苏远大信息股份有限公司

class FakeWebApi implements WebApi {

  @override
  Future<String> login(Map params) async {
    return "[{\"username\":\"超级管理员\",\"userguid\":\"4ce5bed9-78bd-489f-8b3f-a830098759c4\"}]";
  }

  @override
  Future<String> getRealData(Map params) async {
    return "{\"data\":[{\"id\":\"6831008A\",\"name\":\"五接站\",\"aqi\":\"63\",\"time\":\"2020/09/07 09:00\",\"mainPollutes\":[{\"factor\":\"PM25\",\"value\":\"45\",\"unit\":\"μg/m³\"}],\"factorValues\":[{\"factor\":\"PM2.5\",\"value\":\"45\",\"unit\":\"μg/m³\"},{\"factor\":\"PM10\",\"value\":\"58\",\"unit\":\"μg/m³\"},{\"factor\":\"O3\",\"value\":\"120\",\"unit\":\"μg/m³\"},{\"factor\":\"NO2\",\"value\":\"15\",\"unit\":\"μg/m³\"},{\"factor\":\"SO2\",\"value\":\"10\",\"unit\":\"μg/m³\"},{\"factor\":\"CO\",\"value\":\"1.1\",\"unit\":\"mg/m³\"}]},{\"id\":\"6831009A\",\"name\":\"平潮站\",\"aqi\":\"67\",\"time\":\"2020/09/07 09:00\",\"mainPollutes\":[{\"factor\":\"PM25\",\"value\":\"48\",\"unit\":\"μg/m³\"}],\"factorValues\":[{\"factor\":\"PM2.5\",\"value\":\"48\",\"unit\":\"μg/m³\"},{\"factor\":\"PM10\",\"value\":\"79\",\"unit\":\"μg/m³\"},{\"factor\":\"O3\",\"value\":\"110\",\"unit\":\"μg/m³\"},{\"factor\":\"NO2\",\"value\":\"18\",\"unit\":\"μg/m³\"},{\"factor\":\"SO2\",\"value\":\"6\",\"unit\":\"μg/m³\"},{\"factor\":\"CO\",\"value\":\"1.2\",\"unit\":\"mg/m³\"}]}]}";
  }

  @override
  Future<String> getAppVersion(Map params) async {
    return "{\"Version\":{\"verName\":\"1.2.4\",\"verCode\":\"24\",\"verDesc\":\"欢迎使用！\",\"verPath\":\"http://223.113.9.184:8899/EQMSPortalTZ/EnvironmentTZ.apk\"}}";
  }

  @override
  Future<String> getAQIAccumulative(Map params) {
    // TODO: implement getAQIAccumulative
    throw UnimplementedError();
  }

  @override
  Future<String> getAQIAssessment(Map params) {
    // TODO: implement getAQIAssessment
    throw UnimplementedError();
  }

  @override
  Future<String> getFactorTrend(Map params) {
    // TODO: implement getFactorTrend
    throw UnimplementedError();
  }

  @override
  Future<String> getFineDays(Map params) {
    // TODO: implement getFineDays
    throw UnimplementedError();
  }

  @override
  Future<String> getPortInfo(Map params) {
    // TODO: implement getPortInfo
    throw UnimplementedError();
  }

  @override
  Future<String> getRealAQI(Map params) {
    // TODO: implement getRealAQI
    throw UnimplementedError();
  }

  @override
  Future<String> getWeather(Map params) {
    // TODO: implement getWeather
    throw UnimplementedError();
  }


}