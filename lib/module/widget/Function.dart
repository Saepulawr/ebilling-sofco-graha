import 'package:e_billing/module/customer/Customer.dart';
import 'package:e_billing/module/quotation/Quotation.dart';
import 'package:e_billing/module/settings/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';

String companyName = "PT Saffiyah Tech Indonesia";
String CompanyAddress =
    "Kp. Ciketing RT. 001/002 kelurahan. Sumur batu, RT.004/RW.002, kecamatan, Bantargebang, Kota Bks, Jawa Barat 17151";
String companyNpwp = "00-12347667-87";
ZoomDrawerController zoomDrawerController = ZoomDrawerController();
List<Widget> pageMenu = [Quotation(), Customer(), Settings()];
String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

String getPasswordFromHash(String hashid) {
  String h = generateMd5(hashid);
  return h.substring(h.length - 6);
}

void launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
