import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/GLOBAL.dart';
import 'package:recipely/Recipe.dart';
import 'package:recipely/components/MyFloatingButton.dart';
import 'package:recipely/components/MyRecipeImage.dart';
import 'package:recipely/components/MyTextBetween.dart';
import 'package:recipely/components/drawer.dart';
import 'package:recipely/components/MyBottomNav.dart';
import 'package:recipely/theme_notifier.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  int selectedIndex = 0;
  List<Recipe> recipes = [];
  List<Recipe> allRecipes = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allRecipes = data;
    filterRecipes();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    filterRecipes();
  }

  void filterRecipes() {
    String searchText = _searchController.text.toLowerCase();
    recipes = allRecipes
        .where((recipe) =>
            recipe.cuisine == cuisineTypes[selectedIndex] &&
            recipe.name.toLowerCase().contains(searchText))
        .toList();
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        drawer: MyDrawer(),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MyFloatingButton(scaffoldkey: scaffoldkey),
        bottomNavigationBar: const MyBottomNavigation(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Search",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Consumer<ThemeNotifier>(
          builder: (context, notifier, child) => SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                      child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: _searchController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 15.0, right: 10.0),
                              child: Icon(
                                Icons.search,
                                size: 30,
                              ),
                            ),
                            prefixIconColor: Colors.black,
                            hintText: " Search",
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 20)),
                      ),
                    ],
                  )),
                ),
                Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cuisineTypes.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10, right: 20),
                        child: MaterialButton(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          textColor: Colors.black,
                          onPressed: () {
                            setState(() {
                              selectedIndex = i;
                              filterRecipes();
                            });
                          },
                          color: selectedIndex == i
                              ? Color(notifier.mainColor)
                              : Colors.grey[200],
                          child: Text(cuisineTypes[i]),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MyTextBetween(text: "Editor's Choice"),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 490,
                  child: recipes.length == 0
                      ? Center(
                          child: Text(
                            "No items found.",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                        )
                      : ListView.builder(
                          itemCount: recipes.length,
                          itemBuilder: (context, i) {
                            return Card(
                                color: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: MyRecipeImage(
                                          image: recipes[i].image,
                                          id: recipes[i].id)),
                                  // onTap: () {},
                                  title: Text(
                                    recipes[i].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(recipes[i].difficulty),
                                  trailing: const Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ));
                          },
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
