import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/GLOBAL.dart';
import 'package:recipely/theme_notifier.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int _selectedIndex = 0; // Track the selected index for navigation

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    // Navigate to the corresponding route based on the selected index
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed("home");
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed("search");
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed("favorites");
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed("settings");
        break;
      case 4:
        Navigator.of(context).pushReplacementNamed("main");
        // Global.globalUser = null;
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set initial index based on current route
    _updateSelectedIndex(ModalRoute.of(context)!.settings.name);
  }

  void _updateSelectedIndex(String? routeName) {
    setState(() {
      switch (routeName) {
        case "home":
          _selectedIndex = 0;
          break;
        case "search":
          _selectedIndex = 1;
          break;
        case "favorites":
          _selectedIndex = 2;
          break;
        case "settings":
          _selectedIndex = 3;
          break;
        default:
          _selectedIndex = 0; // Default to home if route name is unknown
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) => Drawer(
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.asset(
                        "images/appBarLogo.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                          Global.globalUser!.email.substring(
                              0, Global.globalUser!.email.indexOf("@")),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(Global.globalUser!.email),
                    ),
                  )
                ],
              ),
              _buildDrawerItem(
                context,
                index: 0,
                title: "Home",
                icon: Icons.home,
                notifier: notifier,
              ),
              _buildDrawerItem(
                context,
                index: 1,
                title: "Search",
                icon: Icons.search,
                notifier: notifier,
              ),
              _buildDrawerItem(
                context,
                index: 2,
                title: "Favorites",
                icon: Icons.favorite,
                notifier: notifier,
              ),
              _buildDrawerItem(
                context,
                index: 3,
                title: "Settings",
                icon: Icons.settings,
                notifier: notifier,
              ),
              const Divider(thickness: 1),
              _buildDrawerItem(
                context,
                index: 4,
                title: "Logout",
                icon: Icons.exit_to_app,
                notifier: notifier,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required int index,
      required String title,
      required IconData icon,
      required ThemeNotifier notifier}) {
    return ListTile(
      tileColor:
          _selectedIndex == index ? Color(notifier.mainColor) : Colors.white,
      title: Text(
        title,
        style: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.black,
            fontWeight:
                _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            fontSize: 18),
      ),
      leading: Icon(
        icon,
        color: _selectedIndex == index ? Colors.white : Colors.black,
      ),
      onTap: () {
        _onItemTapped(index);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    );
  }
}
