import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  int _currentIndex = 0;
  double _currentScroll = 0;

  get currentIndex => _currentIndex;

  get currentScroll => _currentScroll;

  void updateIndex(int newIndex) {
    this._currentIndex = newIndex;
    notifyListeners();
  }

  void updateScroll(double newScroll) {
    this._currentScroll = newScroll;
    notifyListeners();
  }
}
