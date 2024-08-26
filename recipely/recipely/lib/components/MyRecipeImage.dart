import 'package:flutter/material.dart';
import 'package:recipely/GLOBAL.dart';
import 'package:recipely/Recipe.dart';
import 'package:recipely/pages/showRecipe.dart';

class MyRecipeImage extends StatelessWidget {
  final String image;
  final int id;
  const MyRecipeImage({super.key, required this.image, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ShowRecipe(),
            settings: RouteSettings(
                arguments: data.firstWhere(
              (element) => element.id == id,
            ))));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
