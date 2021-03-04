import 'package:flutter/material.dart';
import 'package:frame_code/showcase/services/web_api/fake_web_api.dart';
import 'package:frame_code/showcase/services/web_api/web_api.dart';
import 'package:frame_code/showcase/services/web_api/web_api_impl.dart';
import 'package:get_it/get_it.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/5
/// 版权： 江苏远大信息股份有限公司

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {

  serviceLocator.registerLazySingleton<WebApi>(() => FakeWebApi());

}