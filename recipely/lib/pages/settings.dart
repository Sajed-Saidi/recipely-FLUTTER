import 'package:flutter/material.dart';
import 'package:recipely/components/MyFloatingButton.dart';
import 'package:recipely/components/drawer.dart';
import 'package:recipely/components/MyBottomNav.dart';
import 'package:recipely/theme_notifier.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingButton(scaffoldkey: scaffoldkey),
      bottomNavigationBar: const MyBottomNavigation(),
      key: scaffoldkey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Consumer<ThemeNotifier>(
          builder: (context, notifier, child) => SwitchListTile(
            title: const Text('Change Theme'),
            activeColor: Color(notifier.mainColor),
            inactiveTrackColor: Color(notifier.mainColor),
            value: notifier.mainColor == 0xFF70B9BE, // Example condition
            onChanged: (value) {
              if (value) {
                notifier.setMainColor(0xFF70B9BE); // Change to desired color
              } else {
                notifier.setMainColor(0xFFFFD237); // Change to alternate color
              }
            },
          ),
        ),
      ),
    );
  }
}
