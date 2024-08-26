import 'package:flutter/material.dart';
import 'package:recipely/GLOBAL.dart';

class ThemeNotifier with ChangeNotifier {
  int _mainColor = Global.mainColor; // Default color

  int get mainColor => _mainColor;

  void setMainColor(int color) {
    _mainColor = color;
    notifyListeners();
  }
}
