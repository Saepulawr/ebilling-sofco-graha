import 'package:e_billing/module/customer/Customer.dart';
import 'package:e_billing/module/quotation/Quotation.dart';
import 'package:e_billing/module/settings/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

ZoomDrawerController zoomDrawerController = ZoomDrawerController();
List<Widget> pageMenu = [Quotation(), Customer(), Settings()];
