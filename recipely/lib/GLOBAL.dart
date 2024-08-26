import 'package:flutter/material.dart';
import 'package:recipely/Recipe.dart';
import 'package:recipely/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Global {
  static int mainColor = 0xFF70B9BE; // Default color

  static void changeMainColor(int newColor) {
    mainColor = newColor;
  }

  static User? globalUser;
}

const double myMealIconFontSize = 26;
const List mealTypes = [
  {
    "name": "Appetizer",
    "icon": Icon(
      Icons.local_dining, // Appetizer icon
      size: myMealIconFontSize,
    )
  },
  {
    "name": "Breakfast",
    "icon": Icon(
      Icons.breakfast_dining, // Breakfast icon
      size: myMealIconFontSize,
    )
  },
  {
    "name": "Lunch",
    "icon": Icon(
      Icons.restaurant, // Lunch icon
      size: myMealIconFontSize,
    )
  },
  {
    "name": "Dinner",
    "icon": Icon(
      Icons.dinner_dining, // Dinner icon
      size: myMealIconFontSize,
    )
  },
  {
    "name": "Beverage",
    "icon": Icon(
      Icons.local_cafe, // Beverage icon
      size: myMealIconFontSize,
    )
  },
  {
    "name": "Snack",
    "icon": Icon(
      Icons.icecream, // Snack icon
      size: myMealIconFontSize,
    )
  },
  {
    "name": "Side Dish",
    "icon": Icon(
      Icons.dinner_dining, // Side Dish icon (reusing dinner icon for now)
      size: myMealIconFontSize,
    )
  },
  {
    "name": "Dessert",
    "icon": Icon(
      Icons.cake, // Dessert icon
      size: myMealIconFontSize,
    )
  },
];

const cuisineTypes = [
  "Italian",
  "Asian",
  "Indian",
  "Pakistani",
  "Japanese",
  "Moroccan",
  "Korean",
  "Greek",
  "Thai",
  "Turkish",
  "Mexican",
  "Russian",
  "Lebanese",
  "Brazilian",
];

const dishTypes = [
  "Pizza",
  "Stir-fry",
  "Cookies",
  "Pasta",
  "Salsa",
  "Salad",
  "Bruschetta",
  "Caprese",
  "Biryani",
  "Main course",
  "Karahi",
  "Keema",
  "Kebabs",
  "Saag",
  "Ramen",
  "Soup",
  "Tagine",
  "Bibimbap",
  "Moussaka",
  "Butter chicken",
  "Curry",
  "Tiramisu",
  "Grilling",
  "Elote",
  "Street food",
  "Borscht",
  "Dosa",
  "Falafel",
  "Wrap",
  "Cocktail",
];

const mainIngredients = [
  "Vegetarian",
  "Chicken",
  "Beef",
  "Shrimp",
  "Quinoa",
  "Chickpea",
  "Rice",
  "Potatoes",
  "Roti",
  "Chickpea",
  "Smoothie",
  "Blueberry",
  "Banana",
  "Mango",
];

const cookingMethods = ["Baking", "Grilling"];

const beverages = ["Lassi", "Caipirinha"];

List<Recipe> data = [];

void getRecipes() async {
  try {
    final url = Uri.http("dummyjson.com", "/recipes");
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      // if successful call
      final jsonResponse = convert.jsonDecode(response.body);
      final recipes = jsonResponse['recipes'] as List;
      data = recipes.map((json) => Recipe.fromJson(json)).toList();
      // print("=========================");
      // print(data[0].id);
      // print("=========================");
    }
  } catch (e) {
    print(e);
  }
}
