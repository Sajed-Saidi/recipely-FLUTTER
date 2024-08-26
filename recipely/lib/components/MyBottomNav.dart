import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/GLOBAL.dart';
import 'package:recipely/theme_notifier.dart';

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({super.key});

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
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
        builder: (context, notifier, child) => BottomAppBar(
              color: Colors.white,
              notchMargin: 10.0,
              shape: const CircularNotchedRectangle(),
              shadowColor: Color(Global.mainColor),
              elevation: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    onPressed: () => _onItemTapped(0),
                    icon: const Icon(Icons.home_filled),
                    color: _selectedIndex == 0
                        ? Color(notifier.mainColor)
                        : Colors.black,
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () => _onItemTapped(1),
                    icon: const Icon(Icons.search),
                    color: _selectedIndex == 1
                        ? Color(notifier.mainColor)
                        : Colors.black,
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () => _onItemTapped(2),
                    icon: const Icon(Icons.favorite),
                    color: _selectedIndex == 2
                        ? Color(notifier.mainColor)
                        : Colors.black,
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () => _onItemTapped(3),
                    icon: const Icon(Icons.settings),
                    color: _selectedIndex == 3
                        ? Color(notifier.mainColor)
                        : Colors.black,
                    iconSize: 30,
                  ),
                ],
              ),
            ));
  }
}
