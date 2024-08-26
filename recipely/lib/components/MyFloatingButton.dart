import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/theme_notifier.dart';

class MyFloatingButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  const MyFloatingButton({super.key, required this.scaffoldkey});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) => FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          scaffoldkey.currentState!.openDrawer();
        },
        shape: const CircleBorder(),
        child: Icon(
          Icons.person,
          color: Color(notifier.mainColor),
        ),
        elevation: 4, // Remove the shadow
        highlightElevation: 3, // Remove the highlight shadow
      ),
    );
  }
}
