import 'package:cook_it/models/recipe.dart';
import 'package:cook_it/screens_components/icons_widgets.dart';
import 'package:cook_it/screens_constants.dart';
import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

class RecipeScreen extends StatefulWidget {
  static final id = "recipe_screen";
  final Recipe recipe;
  RecipeScreen({required this.recipe});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  Column addRows(List<dynamic> list) {
    List<Widget> textWidgets = [];
    for (String sentence in list) {
      textWidgets.add(Text(sentence));
      textWidgets.add(SizedBox(height: 4));
    }

    if (textWidgets.isEmpty) {
      return Column(children: [Text("no data to show")]);
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: textWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
        backgroundColor: kPrimaryColor,
        actions: [
          HeartIconButton(
            recipeId: widget.recipe.recipeId,
          )
        ],
      ),
      body: ColorfulSafeArea(
        color: kPrimaryColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipe.recipeName,
                  style: kRecipeTitleTextStyle,
                ),
                Container(
                  child: widget.recipe.recipeImageUrl,
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("User: ${widget.recipe.recipeOwner}"),
                    Text("Difficulty: ${widget.recipe.recipeDifficulty}"),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  "Description: ",
                  style: kRecipeTextFieldsTextStyle,
                ),
                Text("${widget.recipe.recipeDescription}"),
                SizedBox(height: 10.0),
                Text(
                  "Preperation: ",
                  style: kRecipeTextFieldsTextStyle,
                ),
                addRows(widget.recipe.recipePreparation),
                SizedBox(height: 10.0),
                Text(
                  "Instructions: ",
                  style: kRecipeTextFieldsTextStyle,
                ),
                addRows(widget.recipe.recipeInstructions),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
