import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import 'home_recipe_post.dart';

class RecipeSearchField extends StatefulWidget {
  final void Function(Map<String, dynamic> recipe) onSuggestionSelected;

  RecipeSearchField({required this.onSuggestionSelected});

  @override
  _RecipeSearchFieldState createState() => _RecipeSearchFieldState();
}

class _RecipeSearchFieldState extends State<RecipeSearchField> {
  final db = FirebaseFirestore.instance;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> recipesStream = db.collection('recipes').snapshots();

    Stream<QuerySnapshot> getRecipesStream() async* {
      if (searchQuery.isEmpty) {
        yield* db.collection('recipes').snapshots();
      } else {
        var allDocs = await db.collection('recipes').get();
        var filteredDocs = allDocs.docs.where((doc) {
          return doc["name"].toString().contains(searchQuery.toLowerCase());
        }).toList();

        yield allDocs;
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            SearchField<Map<String, dynamic>>(
              suggestions: [], // No preloaded suggestions for now
              onSuggestionTap: (suggestion) {
                setState(() {
                  searchQuery = suggestion.searchKey;
                });
                widget.onSuggestionSelected(suggestion.item!);
              },
              onSubmit: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              hint: 'Search for recipes',
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.search),
            ),
          ],
        ),
        if (searchQuery.isNotEmpty)
          Container(
            height: 300.0,
            child: StreamBuilder<QuerySnapshot>(
              stream: getRecipesStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  final recipes = snapshot.data!.docs.where((doc) {
                    return doc["name"]
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase());
                  }).toList();
                  List<Widget> recipeWidgets = [];
                  for (var recipe in recipes) {
                    final recipeData = recipe.data()! as Map<String, dynamic>;
                    final recipeDescription = recipeData["description"];
                    final recipeDifficulty = recipeData["difficulty"];
                    final recipeTimesFavorited = recipeData["favorited"];
                    final recipeImageUrl = recipeData["imageUrl"];
                    final recipeImage = Image.network(recipeImageUrl);
                    final recipeInstructions = recipeData["instructions"];
                    final recipeName = recipeData["name"];
                    final recipePreparation = recipeData["preparation"];
                    final recipeOwner = recipeData["owner"];
                    final recipePost = HomeRecipePost(
                      recipeDescription: recipeDescription,
                      recipeDifficulty: recipeDifficulty,
                      recipeTimesFavorited: recipeTimesFavorited,
                      recipeImage: recipeImage,
                      recipeInstructions: recipeInstructions,
                      recipeName: recipeName,
                      recipePreparation: recipePreparation,
                      recipeOwner: recipeOwner,
                      recipeId: recipe.id,
                    );
                    recipeWidgets
                      ..add(recipePost)
                      ..add(SizedBox(height: 10.0));
                  }
                  return ListView(
                    children: recipeWidgets,
                  );
                }
                return Text('Unknown state');
              },
            ),
          ),
      ],
    );
  }
}
