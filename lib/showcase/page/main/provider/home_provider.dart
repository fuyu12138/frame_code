
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {

  int _index = 0;
  PageController _pageController = PageController();

  PageController get pageController => _pageController;

  int get index => _index;

  set index(int value) {
    _index = value;
    pageController.jumpToPage(this._index);
    notifyListeners();
  }
}