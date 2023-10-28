import 'package:cook_it/models/recipe.dart';
import 'package:cook_it/models/recipe_data.dart';
import 'package:cook_it/screens/category_recipes_screen.dart';
import 'package:cook_it/screens_components/categories_listview.dart';
import 'package:cook_it/screens_components/recipe_searchfield.dart';
import 'package:cook_it/services/home_recipe_stream.dart';
import 'package:cook_it/screens_components/home_text_row.dart';
import 'package:cook_it/services/recipe_manager.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenBody extends StatefulWidget {
  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  Recipe? recipe;
  List<Map<String, dynamic>> recipes = [];
  String? selectedCategory;

  Future<List<Map<String, dynamic>>> fetchRecipesFromFirebase() async {
    final recipesCollection = FirebaseFirestore.instance.collection('recipes');
    final querySnapshot = await recipesCollection.get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  void fetchTopRecipes() {
    RecipeManager recipeManager = RecipeManager();
    recipeManager.updatePopularRecipes();
  }

  @override
  void initState() {
    super.initState();
    _fetchAndSetRecipes();
    fetchTopRecipes();
  }

  _fetchAndSetRecipes() async {
    final fetchedRecipes = await fetchRecipesFromFirebase();
    setState(() {
      recipes = fetchedRecipes;
    });
  }

  void _showCategoriesModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height *
                0.5, // e.g., 50% of screen height
            child: ListView.builder(
              itemCount: categoriesList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("${emoji[index]} ${categoriesList[index]}"),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CategoryRecipesScreen.id,
                      arguments: categoriesList[index],
                    );
                  },
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SearchField<Map<String, dynamic>>(
          //   suggestions: recipes.map((recipeMap) {
          //     return SearchFieldListItem<Map<String, dynamic>>(
          //       recipeMap[
          //           'name'], // Assuming 'recipename' is the field's name in Firebase
          //       item: recipeMap,
          //       child: Text(recipeMap['name']),
          //     );
          //   }).toList(),
          // ),
          RecipeSearchField(onSuggestionSelected: (selectedRecipe) {}),
          HomeTextRow(
            text: 'Category',
            function: () => _showCategoriesModal(context),
          ),
          Container(
            child: CategoriesListView(
              maxCount: 5,
              onCategorySelected: (selectedCat) {
                setState(() {
                  selectedCategory = selectedCat;
                });
              },
            ),
            height: 50.0,
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              "Popular Recipes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Expanded(
            flex: 16,
            child: HomeRecipesStream(),
          ),
        ],
      ),
    );
  }
}
