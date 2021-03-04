import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/5
/// 版权： 江苏远大信息股份有限公司

enum HttpMethod {
  GET,
  POST,
  DELETE,
  PUT
}

const MethodValues = {
  HttpMethod.GET: "get",
  HttpMethod.POST: "post",
  HttpMethod.DELETE: "delete",
  HttpMethod.PUT: "put"
};