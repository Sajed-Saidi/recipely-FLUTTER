import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/theme_notifier.dart';

class FeaturedBox extends StatelessWidget {
  final String name;
  final String description;
  final String time;

  const FeaturedBox(
      {super.key,
      required this.name,
      required this.description,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, notifier, child) => Container(
              margin: const EdgeInsets.only(right: 20),
              width: 230,
              height: 200,
              decoration: BoxDecoration(
                  color: Color(notifier.mainColor),
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  Image.asset(
                    'images/featured.png',
                    // color: Colors.red,
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                          left: 20, top: 60, right: 20, bottom: 0),
                      width: 230,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Text(
                            description,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timer_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    time,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ));
  }
}
