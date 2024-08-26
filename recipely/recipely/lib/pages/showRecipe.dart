import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recipely/Recipe.dart';
import 'package:recipely/components/FavoriteButton.dart';
import 'package:recipely/components/MyFloatingButton.dart';
import 'package:recipely/components/MyIconButton.dart';
import 'package:recipely/components/MyText.dart';
import 'package:recipely/components/MyTextBetween.dart';
import 'package:recipely/components/drawer.dart';
import 'package:recipely/components/MyBottomNav.dart';
import 'package:recipely/theme_notifier.dart';

class ShowRecipe extends StatefulWidget {
  const ShowRecipe({super.key});

  @override
  State<ShowRecipe> createState() => _ShowRecipeState();
}

class _ShowRecipeState extends State<ShowRecipe>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  TabController? tabcontroller;

  @override
  void initState() {
    tabcontroller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context)!.settings.arguments as Recipe;

    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingButton(scaffoldkey: scaffoldkey),
      bottomNavigationBar: const MyBottomNavigation(),
      key: scaffoldkey,
      body: Consumer<ThemeNotifier>(
        builder: (context, notifier, child) => Stack(
          children: [
            Image.network(recipe.image),
            Positioned(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyIconButton(
                      icon: const Icon(Icons.close),
                      iconColor: Colors.black,
                      iconBGColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FavoriteButton(recipe: recipe)
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(
                margin: const EdgeInsets.only(top: 350),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 211, 215, 222),
                            borderRadius: BorderRadius.circular(20)),
                        width: 100,
                        height: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(text: recipe.name),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${recipe.cookTimeMinutes} min",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recipe.instructions[0] +
                          recipe.instructions[1] +
                          recipe.instructions[2],
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 130,
                      width: 400,
                      child: GridView(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 50,
                        ),
                        children: [
                          Row(
                            children: [
                              const MyIconButton(
                                icon: Icon(FontAwesomeIcons.wheatAwn),
                                iconColor: Colors.black,
                                iconBGColor: Color(0xFFE6EBF2),
                              ),
                              const SizedBox(width: 12),
                              Text("${recipe.caloriesPerServing} KCal"),
                            ],
                          ),
                          Row(
                            children: [
                              const MyIconButton(
                                icon: Icon(FontAwesomeIcons.clock),
                                iconColor: Colors.black,
                                iconBGColor: Color(0xFFE6EBF2),
                              ),
                              const SizedBox(width: 12),
                              Text("${recipe.prepTimeMinutes} prep time"),
                            ],
                          ),
                          Row(
                            children: [
                              const MyIconButton(
                                icon: Icon(FontAwesomeIcons.fire),
                                iconColor: Colors.black,
                                iconBGColor: Color(0xFFE6EBF2),
                              ),
                              const SizedBox(width: 12),
                              Text("${recipe.reviewCount} review"),
                            ],
                          ),
                          Row(
                            children: [
                              const MyIconButton(
                                icon: Icon(FontAwesomeIcons.star),
                                iconColor: Colors.black,
                                iconBGColor: Color(0xFFE6EBF2),
                              ),
                              const SizedBox(width: 12),
                              Text("${recipe.rating} rating"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: const Color(0xFFE6EBF2),
                            ),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              labelColor: Colors.white,
                              dividerColor: Colors.transparent,
                              controller: tabcontroller,
                              indicatorColor: Colors.blue,
                              unselectedLabelColor: Colors.black54,
                              tabs: const [
                                Tab(
                                  text: "Ingredients",
                                ),
                                Tab(
                                  text: "Instructions",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        controller: tabcontroller,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                MyTextBetween(
                                  text: "Ingredients",
                                  trailing:
                                      "${recipe.ingredients.length} Items",
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                ...List.generate(recipe.ingredients.length,
                                    (i) {
                                  return ListTile(
                                    leading: Container(
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(notifier.mainColor),
                                      ),
                                      alignment: Alignment.center,
                                      // child: Text(
                                      //   '${i + 1}',
                                      //   style: const TextStyle(
                                      //       color: Colors.white, fontSize: 20),
                                      // ),
                                    ),
                                    title: Text(
                                      recipe.ingredients[i],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(children: [
                              MyTextBetween(
                                text: "Instructions",
                                trailing: "${recipe.instructions.length} Steps",
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              ...List.generate(recipe.instructions.length, (i) {
                                return ListTile(
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(notifier.mainColor),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${i + 1}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  title: Text(
                                    recipe.instructions[i],
                                  ),
                                );
                              }),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
