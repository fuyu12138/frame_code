import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/12
/// 版权： 江苏远大信息股份有限公司

class GISPageProvider extends ChangeNotifier {
  bool _showPointName = false;
  int _topBarType = 0;
  int _lastTopBarType = 0;
  int _detailType = 0;

  bool get getPointNameStatus => _showPointName;
  int get topBarType => _topBarType;
  int get lastTopBarType => _lastTopBarType;
  int get detailType => _detailType;

  /// 切换站点名称显示状态
  void changeNameStatus() {
    this._showPointName = !_showPointName;
    notifyListeners();
  }

  /// 切换顶部筛选
  void setTopBarType(int type) {
    this._lastTopBarType = _topBarType;
    this._topBarType = type;
    notifyListeners();
  }

  /// 切换站点详情界面
  void setPositionDetailType(int type) {
    this._detailType = type;
    notifyListeners();
  }
}