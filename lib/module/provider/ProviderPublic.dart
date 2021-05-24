import 'package:e_billing/module/login/model/ModelLogin.dart';
import 'package:e_billing/module/widget/Api.dart';
import 'package:flutter/material.dart';

class ProviderPublic extends ChangeNotifier {
  int _selectedMenuIndex = 0;
  int get selectedMenuIndex => _selectedMenuIndex;
  void setSelectedMenuIndex(int num) {
    _selectedMenuIndex = num;
    notifyListeners();
  }

  //login
  late ModelLogin _modelLogin;
  ModelLogin get modelLogin => _modelLogin;
  void setModelLogin(ModelLogin modelLogin) {
    _modelLogin = modelLogin;
    API_TOKEN = modelLogin.token!;
    notifyListeners();
  }

  //customer

}
