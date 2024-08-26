import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/GLOBAL.dart';
import 'package:recipely/pages/favorites.dart';
import 'package:recipely/pages/home.dart';
import 'package:recipely/pages/login.dart';
import 'package:recipely/pages/main.dart';
import 'package:recipely/pages/search.dart';
import 'package:recipely/pages/settings.dart';
import 'package:recipely/pages/signUp.dart';
import 'package:recipely/theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    getRecipes();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(Provider.of<ThemeNotifier>(context).mainColor),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Mainpage(),
      routes: {
        'main': (context) => const Mainpage(),
        'login': (context) => const Loginpage(),
        'signUp': (context) => const Signup(),
        "home": (context) => const Home(),
        "favorites": (context) => const Favorites(),
        "settings": (context) => const Settings(),
        "search": (context) => const Search()
      },
    );
  }
}
