import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/GLOBAL.dart';
import 'package:recipely/Recipe.dart';
import 'package:recipely/components/FavoriteButton.dart';
import 'package:recipely/components/MyFloatingButton.dart';
import 'package:recipely/components/MyIconButton.dart';
import 'package:recipely/components/MyRecipeImage.dart';
import 'package:recipely/components/MySpace.dart';
import 'package:recipely/components/MyTextBetween.dart';
import 'package:recipely/components/drawer.dart';
import 'package:recipely/components/MyBottomNav.dart';
import 'package:recipely/favorite.dart';
import 'package:recipely/theme_notifier.dart';

bool inFavorites(Recipe recipe) {
  return favorites.indexWhere((element) => element.id == recipe.id) != -1;
}

void handleFavoriteRecipe(Recipe recipe) {
  if (inFavorites(recipe)) {
    favorites
        .remove(favorites.firstWhere((element) => element.id == recipe.id));
    removeFavorite(recipe.id);
  } else {
    favorites.add(data.firstWhere((rec) => rec.id == recipe.id));
    addFavorite(recipe.id);
  }
}

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    getFavorites(update);
  }

  void update(bool success) {
    // if (!success) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text('Something Went Wrong!')));
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text('Favorites Loaded!')));
    // }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        drawer: const MyDrawer(),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MyFloatingButton(scaffoldkey: scaffoldkey),
        bottomNavigationBar: const MyBottomNavigation(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            "Favorites",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Consumer<ThemeNotifier>(
          builder: (context, notifier, child) => Container(
            padding:
                const EdgeInsets.only(top: 20, right: 20, bottom: 0, left: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(2, 2))
                      ]),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 50, // Adjust the radius as needed
                      backgroundImage: AssetImage(
                          'images/avatar.png'), // Replace with your image URL
                    ),
                    title: Text(
                      Global.globalUser!.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: const Text("Recipe Developer"),
                    trailing: const MyIconButton(
                        icon: Icon(Icons.arrow_forward_rounded),
                        iconColor: Colors.white,
                        iconBGColor: Colors.black),
                  ),
                ),
                const MySpace(),
                const MyTextBetween(text: "My Favorites"),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 330,
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : favorites.length == 0
                          ? const Text(
                              "No favorites.",
                              style: TextStyle(fontSize: 24),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, mainAxisExtent: 230),
                              itemCount: favorites.length,
                              itemBuilder: (context, i) {
                                Recipe favorite = favorites[i];
                                return Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, right: 20, left: 20, bottom: 0),
                                  margin: const EdgeInsets.only(
                                      right: 20, bottom: 20),
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
                                          MyRecipeImage(
                                              image: favorite.image,
                                              id: favorite.id),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            favorite.name,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 6),
                                        ],
                                      ),
                                      Positioned(
                                          top: 10,
                                          right: 10,
                                          child: FavoriteButton(
                                            recipe: favorite,
                                            onPressed: () {
                                              setState(() {
                                                favorite.isFavorite =
                                                    !favorite.isFavorite;
                                                handleFavoriteRecipe(favorite);
                                              });
                                            },
                                          ))
                                    ],
                                  ),
                                );
                              }),
                )
              ],
            ),
          ),
        ));
  }
}
