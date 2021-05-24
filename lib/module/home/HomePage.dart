import 'package:e_billing/module/drawer-menu/DrawerMenu.dart';
import 'package:e_billing/module/provider/ProviderPublic.dart';
import 'package:e_billing/module/widget/Function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      // slideWidth: MediaQuery.of(context).size.width * 0.50,
      angle: -12,
      borderRadius: 24.0,
      // mainScreenScale: 0.1,

      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.fastOutSlowIn,
      style: DrawerStyle.Style1,
      menuScreen: DrawerMenu(),
      mainScreen:
          pageMenu[Provider.of<ProviderPublic>(context).selectedMenuIndex],
    );
  }
}
