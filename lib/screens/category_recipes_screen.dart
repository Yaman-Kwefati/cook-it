import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_it/screens_components/home_recipe_post.dart';
import 'package:flutter/material.dart';

class CategoryRecipesScreen extends StatefulWidget {
  static final id = "category_recipes_screen";
  final String? category;

  CategoryRecipesScreen({this.category});

  @override
  State<CategoryRecipesScreen> createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  final db = FirebaseFirestore.instance;
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final String? category =
        ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text(category ?? "Default Category"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection("recipes")
            .where('category', isEqualTo: category)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // or another suitable loading widget
          }

          if (snapshot.hasData) {
            final recipes = snapshot.data!.docs;
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
    );
  }
}
