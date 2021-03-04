import 'package:flutter/material.dart';
import 'dart:convert' show json;

/// 作者： 付雨
/// 创建时间： 2020/9/5
/// 版权： 江苏远大信息股份有限公司

class UserModel with ChangeNotifier{
  String userguid;
  String username;

  UserModel.fromParams({this.userguid, this.username});

  factory UserModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? UserModel.fromJson(json.decode(jsonStr)) : UserModel.fromJson(jsonStr);

  UserModel.fromJson(jsonRes) {
    userguid = jsonRes['userguid'];
    username = jsonRes['username'];
  }

  @override
  String toString() {
    return '{"userguid": ${userguid != null?'${json.encode(userguid)}':'null'}, "username": ${username != null?'${json.encode(username)}':'null'}}';
  }
}