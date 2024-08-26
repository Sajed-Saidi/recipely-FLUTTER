import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/GLOBAL.dart';
import 'package:recipely/Recipe.dart';
import 'package:recipely/components/MyFloatingButton.dart';
import 'package:recipely/components/MySpace.dart';
import 'package:recipely/components/MyText.dart';
import 'package:recipely/components/MyTextBetween.dart';
import 'package:recipely/components/drawer.dart';
import 'package:recipely/components/featuredBox.dart';
import 'package:recipely/components/popularBox.dart';
import 'package:recipely/components/MyBottomNav.dart';
import 'package:recipely/theme_notifier.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  int selectedIndex = 0;
  List<Recipe> recipes = data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterRecipes();
  }

  void filterRecipes() {
    recipes = data.getRange(0, 6).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: MyDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MyFloatingButton(
          scaffoldkey: scaffoldkey,
        ),
        bottomNavigationBar: const MyBottomNavigation(),
        key: scaffoldkey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.notifications_none,
                size: 30.0,
              ),
            )
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.blueGrey,
                        blurRadius: 20,
                        spreadRadius: 10,
                        offset: Offset(10, 10))
                  ],
                  color: Colors.grey[100],
                ),
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "images/appBarLogo.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Consumer<ThemeNotifier>(
          builder: (context, notifier, child) => Container(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: ListView(
              children: [
                Text(
                  "Hello ${Global.globalUser!.email.substring(0, Global.globalUser!.email.indexOf("@"))}!",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "Make your own food,",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
                Row(
                  children: [
                    const Text(
                      "stay at",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "home",
                      style: TextStyle(
                          color: Color(notifier.mainColor),
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
                const MySpace(),
                const MyText(text: "Featured"),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      FeaturedBox(
                          name: "James Joth",
                          description: "Asian white noodle with extra seafood.",
                          time: "20 min"),
                      FeaturedBox(
                          name: "Sajed Saidi",
                          description:
                              "Black african nigga with extra mayonaize.",
                          time: "16 min"),
                      FeaturedBox(
                          name: "Maya Daher",
                          description: "Short smurf zenji with extra kabis.",
                          time: "10 min")
                    ],
                  ),
                ),
                const MySpace(),
                const MyTextBetween(text: "Meal Types"),
                Container(
                  height: 150,
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: const EdgeInsets.only(right: 20),
                        height: 100,
                        // padding: const EdgeInsets.all(8),
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              selectedIndex = i;
                              // filterRecipes();
                            });
                          },
                          child: Column(children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 18),
                              decoration: BoxDecoration(
                                  color: i == selectedIndex
                                      ? Color(notifier.mainColor)
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(200)),
                              child: mealTypes[i]['icon'],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(mealTypes[i]['name'])
                          ]),
                        ),
                      );
                    },
                    itemCount: mealTypes.length,
                  ),
                ),
                const MyTextBetween(text: "Popular Recipes"),
                const MySpace(),
                SizedBox(
                  height: 270,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recipes.length,
                      itemBuilder: (context, i) {
                        return PopularBox(recipe: recipes[i]);
                      }),
                ),
                const MySpace()
              ],
            ),
          ),
        ));
  }
}
