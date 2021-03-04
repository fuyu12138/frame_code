import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/10
/// 版权： 江苏远大信息股份有限公司

class MojsProvider extends ChangeNotifier {
  bool _showLoading = false;

  bool get getLoadingState => _showLoading;

  void showLoading(bool showLoading) {
    this._showLoading = showLoading;
    notifyListeners();
  }
}