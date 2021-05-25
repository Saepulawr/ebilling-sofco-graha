import 'package:e_billing/module/home/HomePage.dart';
import 'package:e_billing/module/login/LoginPage.dart';
import 'package:e_billing/module/quotation/QuotationAdd.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  "/": (context) => LoginPage(),
  "/home": (context) => HomePage(),
};

enum RoutesName {
  loginPage,
  homePage,
}
String getRoutesName(RoutesName routesName) {
  return routes.keys.toList()[routesName.index];
}
