import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frame_code/frame/net/base_entity.dart';
import 'package:frame_code/frame/net/dio_manager.dart';
import 'package:frame_code/frame/net/http_api.dart';
import 'package:frame_code/frame/net/http_method.dart';
import 'package:frame_code/showcase/model/user_model.dart';
import 'package:frame_code/showcase/services/web_api/web_api.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/5
/// 版权： 江苏远大信息股份有限公司

class WebApiImpl implements WebApi {
  DioManager _dioManager = new DioManager();

  @override
  Future<String> login(Map params) async {
    String result = await _dioManager.request(
      HttpMethod.POST,
      HttpApi.loginPath,
      params: params,
    );

    BaseEntity entity = BaseEntity(result);
    if(entity.data!=null){
      return entity.data;
    }else {
      return null;
    }
  }

  @override
  Future<String> getRealData(Map params) async {
    String result = await _dioManager.request(
      HttpMethod.POST,
      HttpApi.realData,
      params: params,
    );

    BaseEntity entity = BaseEntity(result);
    if(entity.data!=null){
      return entity.data;
    }else {
      return null;
    }
  }

  @override
  Future<String> getAppVersion(Map params) async {
    String result = await _dioManager.request(
      HttpMethod.POST,
      HttpApi.versionInfo,
      params: params,
    );

    BaseEntity entity = BaseEntity(result);
    if(entity.data!=null){
      return entity.data;
    }else {
      return null;
    }
  }

  @override
  Future<String> getAQIAccumulative(Map params) async {
    String result = await _dioManager.request(
      HttpMethod.POST,
      HttpApi.aqiAccumulative,
      params: params,
    );

    BaseEntity entity = BaseEntity(result);
    if(entity.data!=null){
      return entity.data;
    }else {
      return null;
    }
  }

  @override
  Future<String> getAQIAssessment(Map params) async {
    String result = await _dioManager.request(
      HttpMethod.POST,
      HttpApi.aqiAssessment,
      params: params,
    );

    BaseEntity entity = BaseEntity(result);
    if(entity.data!=null){
      return entity.data;
    }else {
      return null;
    }
  }

  @override
  Future<String> getFactorTrend(Map params) async {
    String result = await _dioManager.request(
      HttpMethod.POST,
      HttpApi.factorTrend,
      params: params,
    );

    BaseEntity entity = BaseEntity(result);
    if(entity.data!=null){
      return entity.data;
    }else {
      return null;
    }
  }

  @override
  Future<String> getFineDays(Map params) async {
    String result = await _dioManager.request(
      HttpMethod.POST,
      HttpApi.fineDays,
      params: params,
    );

    BaseEntity entity = BaseEntity(result);
    if(entity.data!=null){
      return entity.data;
    }else {
      return null;
    }
  }

  @override
  Future<String> getPortInfo(Map params) async {
    String result = await _dioManager.request(
      HttpMethod.POST,
      HttpApi.airPortInfo,
      params: params,
    );

    BaseEntity entity = BaseEntity(result);
    if(entity.data!=null){
      return entity.data;
    }else {
      return null;
    }
  }

  @override
  Future<String> getRealAQI(Map params) async {
    String result = await _dioManager.request(
      HttpMethod.POST,
      HttpApi.realAQI,
      params: params,
    );

    BaseEntity entity = BaseEntity(result);
    if(entity.data!=null){
      return entity.data;
    }else {
      return null;
    }
  }

  @override
  Future<String> getWeather(Map params) async {
    String result = await _dioManager.request(
      HttpMethod.POST,
      HttpApi.weather,
      params: params,
    );

    BaseEntity entity = BaseEntity(result);
    if(entity.data!=null){
      return entity.data;
    }else {
      return null;
    }
  }
}