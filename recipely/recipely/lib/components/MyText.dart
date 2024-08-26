import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  const MyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 110,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
        softWrap: true,
      ),
    );
  }
}
