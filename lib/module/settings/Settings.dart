import 'package:e_billing/module/widget/Function.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              zoomDrawerController.toggle!();
            }),
        title: Text("Settings"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Section',
            tiles: [
              SettingsTile(
                title: 'Company Name',
                subtitle: 'PT Saffiyah Tech',
                leading: Icon(Icons.title),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Company Address',
                subtitle:
                    'Kp. Ciketing RT. 001/002 kelurahan. Sumur batu, RT.004/RW.002, kecamatan, Bantargebang, Kota Bks, Jawa Barat 17151',
                subtitleMaxLines: 3,
                leading: Icon(Icons.place),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'NPWP',
                subtitle: '00-12347667-87',
                leading: Icon(Icons.badge),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
