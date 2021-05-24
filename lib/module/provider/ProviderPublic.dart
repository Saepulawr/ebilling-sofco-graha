import 'package:flutter/material.dart';

class ProviderPublic extends ChangeNotifier {
  int _selectedMenuIndex = 0;
  int get selectedMenuIndex => _selectedMenuIndex;
  void setSelectedMenuIndex(int num) {
    _selectedMenuIndex = num;
    notifyListeners();
  }
}
