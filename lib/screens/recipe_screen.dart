import 'package:cook_it/models/recipe.dart';
import 'package:cook_it/screens_components/icons_widgets.dart';
import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  static final id = "recipe_screen";
  final Recipe recipe;
  RecipeScreen({required this.recipe});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.recipe.recipeName}"),
      ),
      body: Column(
        children: [
          Container(
            child: widget.recipe.recipeImageUrl,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Text("Difficulty: ${widget.recipe.recipeDifficulty}"),
                Text("Description: ${widget.recipe.recipeDescription}"),
                Text("Preperation: ${widget.recipe.recipePreparation}"),
                Text("Instructions: ${widget.recipe.recipeInstructions}"),
                Text("User: ${widget.recipe.recipeOwner}"),
              ],
            ),
          ),
          HeartIconButton(
            recipeId: widget.recipe.recipeId,
          )
        ],
      ),
    );
  }
}
