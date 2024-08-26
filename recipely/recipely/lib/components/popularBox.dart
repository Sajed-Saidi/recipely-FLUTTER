import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/Recipe.dart';
import 'package:recipely/components/FavoriteButton.dart';
import 'package:recipely/components/MyRecipeImage.dart';
import 'package:recipely/theme_notifier.dart';

class PopularBox extends StatelessWidget {
  final Recipe recipe;
  const PopularBox({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) => Container(
        padding: const EdgeInsets.all(20),
        width: 190,
        height: 270,
        margin: const EdgeInsets.only(bottom: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  blurStyle: BlurStyle.outer,
                  offset: Offset(4, 4))
            ]),
        child: Stack(
          children: [
            Column(
              children: [
                MyRecipeImage(image: recipe.image, id: recipe.id),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  recipe.name,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w800),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.bloodtype_outlined,
                      color: Colors.grey,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${recipe.caloriesPerServing} Kcal",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.watch_later_outlined,
                      color: Colors.grey,
                      size: 18,
                    ),
                    Text(
                      "${recipe.cookTimeMinutes} min",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(child: FavoriteButton(recipe: recipe)),
            )
          ],
        ),
      ),
    );
  }
}
