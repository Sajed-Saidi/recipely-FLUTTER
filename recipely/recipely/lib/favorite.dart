import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:recipely/GLOBAL.dart';
import 'package:recipely/Recipe.dart';

const String _baseURL = 'recipely.atwebpages.com';

List<Recipe> favorites = [];

void getFavorites(Function(bool success) update) async {
  try {
    final url = Uri.http(
        _baseURL, 'getFavorites.php', {"user_id": '${Global.globalUser!.id}'});
    print(url);
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      // if successful call
      favorites = [];
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Recipe rec =
            data.firstWhere((rec) => rec.id == int.parse(row['recipe_id']));
        favorites.add(rec);
      }
      update(true);
    }
  } catch (e) {
    print(e);
    update(false);
  }
}

void addFavorite(int recipe_id) async {
  try {
    final response = await http
        .post(Uri.parse('http://$_baseURL/insertFavorite.php'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: convert.jsonEncode(<String, String>{
              'user_id': '${Global.globalUser!.id}',
              'recipe_id': '$recipe_id',
            }))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      // Parse the JSON response
      print(response.body);
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
  }
}

void removeFavorite(int recipe_id) async {
  print("hlo");
  try {
    final response = await http
        .post(Uri.parse('http://$_baseURL/removeFavorite.php'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: convert.jsonEncode(<String, String>{
              'user_id': '${Global.globalUser!.id}',
              'recipe_id': '$recipe_id',
            }))
        .timeout(const Duration(seconds: 10));
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Parse the JSON response
      print(response.body);
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print("Error");
  }
}
