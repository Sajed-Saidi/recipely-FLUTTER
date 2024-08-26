import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:recipely/GLOBAL.dart';
import 'package:recipely/theme_notifier.dart';

class MyTextBetween extends StatelessWidget {
  final String text;
  final String trailing;
  const MyTextBetween(
      {super.key, required this.text, this.trailing = "See All"});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, notifier, child) => Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    trailing,
                    style: TextStyle(
                        color: Color(notifier.mainColor),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ));
  }
}
