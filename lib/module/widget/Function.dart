import 'package:e_billing/module/customer/Customer.dart';
import 'package:e_billing/module/quotation/Quotation.dart';
import 'package:e_billing/module/settings/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

String companyName = "PT Saffiyah Tech Indonesia";
String CompanyAddress =
    "Kp. Ciketing RT. 001/002 kelurahan. Sumur batu, RT.004/RW.002, kecamatan, Bantargebang, Kota Bks, Jawa Barat 17151";
String companyNpwp = "00-12347667-87";
ZoomDrawerController zoomDrawerController = ZoomDrawerController();
List<Widget> pageMenu = [Quotation(), Customer(), Settings()];
