import 'package:e_billing/module/widget/Function.dart';
import 'package:e_billing/routes.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Theme.of(context).primaryColor,
          Colors.green,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      padding: EdgeInsets.only(left: 10, top: 50),
      alignment: Alignment.centerLeft,
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/images/pp.jpeg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 36),
                child: Text(
                  "Mawar Mutiara",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
              //-----menu
              MenuItemWidget(
                callback: (index) {
                  zoomDrawerController.close!();
                  homeKey.currentState!.setState(() {
                    selectedIndexMenu = index;
                  });
                },
                selected: selectedIndexMenu == 0,
                item: MenuItem("Quotation", Icons.description, 0),
              ),
              MenuItemWidget(
                callback: (index) {
                  zoomDrawerController.close!();
                  homeKey.currentState!.setState(() {
                    selectedIndexMenu = index;
                  });
                },
                selected: selectedIndexMenu == 1,
                item: MenuItem("Customer", Icons.person, 1),
              ),
              MenuItemWidget(
                callback: (index) {
                  zoomDrawerController.close!();
                  homeKey.currentState!.setState(() {
                    selectedIndexMenu = index;
                  });
                },
                selected: selectedIndexMenu == 2,
                item: MenuItem("Settings", Icons.settings, 2),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 2.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.of(context)
                      .popAndPushNamed(getRoutesName(RoutesName.homePage)),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class MenuItemWidget extends StatelessWidget {
  final MenuItem? item;
  final Widget? widthBox;
  final TextStyle? style;
  final Function? callback;
  final bool? selected;

  final white = Colors.white;

  const MenuItemWidget({
    Key? key,
    required this.item,
    this.widthBox,
    this.style,
    required this.callback,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => callback!(item!.index),
      style: TextButton.styleFrom(
        primary: selected! ? Color(0x44000000) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            item!.icon,
            color: white,
            size: 24,
          ),
          widthBox ??
              SizedBox(
                width: 30,
              ),
          Expanded(
            child: Text(
              item!.title,
              style: style ?? TextStyle(color: Colors.white, fontSize: 22),
            ),
          )
        ],
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final int index;

  const MenuItem(this.title, this.icon, this.index);
}
