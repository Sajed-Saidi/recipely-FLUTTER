import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/theme_notifier.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ThemeNotifier>(
      builder: (context, notifier, child) => Container(
        color: Color(notifier.mainColor),
        child: Column(
          children: [
            Container(
                child: Stack(
              children: [
                Positioned(
                  // top: -120,
                  right: 5,
                  child: Container(
                    child: Image.asset(
                      "images/Vector 1.png",
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: -1,
                  child: Container(
                    child: Image.asset(
                      "images/Vector 3.png",
                    ),
                  ),
                ),
                Positioned(
                  top: 240,
                  right: 5,
                  child: Container(
                    child: Image.asset(
                      "images/Vector 2.png",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 140),
                  width: 400,
                  height: 400,
                  child: Image.asset("images/main.png"),
                ),
              ],
            )),
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Help your path to health goals with happiness",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: 350,
              height: 55,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("login");
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("signUp");
                },
                child: const Text(
                  "Create New Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
