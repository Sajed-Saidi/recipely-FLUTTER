import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/Recipe.dart';
import 'package:recipely/pages/favorites.dart';
import 'package:recipely/theme_notifier.dart';

class FavoriteButton extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onPressed;

  FavoriteButton({super.key, required this.recipe, this.onPressed});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late Recipe recipe;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    recipe = widget.recipe;
    isFavorite = inFavorites(recipe);
  }

  void _defaultOnPressed() {
    setState(() {
      handleFavoriteRecipe(recipe);
      isFavorite = inFavorites(recipe);
      print(recipe.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) => Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(4)),
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(
            size: 20,
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Color(notifier.mainColor) : Colors.black,
          ),
          onPressed: widget.onPressed ?? _defaultOnPressed,
        ),
      ),
    );
  }
}
