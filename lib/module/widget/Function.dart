import 'package:e_billing/module/custumer/Customer.dart';
import 'package:e_billing/module/home-page/HomePage.dart';

import 'package:e_billing/module/login-page/model/ModelLogin.dart';
import 'package:e_billing/module/quotation/Quotation.dart';
import 'package:e_billing/module/settings/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

ModelLogin modelLogin = ModelLogin();
GlobalKey<HomePageState> homeKey = GlobalKey();
ZoomDrawerController zoomDrawerController = ZoomDrawerController();
int selectedIndexMenu = 0;
List<Widget> pageMenu = [Quotation(), Customer(), Settings()];
String ee = "ff";
