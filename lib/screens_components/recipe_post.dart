import 'package:cook_it/screens/recipe_screen.dart';
import 'package:cook_it/screens_components/icons_widgets.dart';
import 'package:cook_it/screens_constants.dart';
import 'package:cook_it/services/recipe_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../models/recipe.dart';

class FavoriteRecipePost extends StatefulWidget {
  FavoriteRecipePost(
      {required this.recipeDescription,
      required this.recipeDifficulty,
      required this.recipeTimesFavorited,
      required this.recipeImage,
      required this.recipeInstructions,
      required this.recipeName,
      required this.recipePreparation,
      required this.recipeOwner,
      required this.recipeId});

  final recipeDescription;
  final recipeDifficulty;
  final recipeTimesFavorited;
  final recipeImage;
  final recipeInstructions;
  final recipeName;
  final recipePreparation;
  final recipeOwner;
  final recipeId;

  @override
  State<FavoriteRecipePost> createState() => _FavoriteRecipePostState();
}

class _FavoriteRecipePostState extends State<FavoriteRecipePost> {
  double? rating;
  final RecipeManager recipeManager = RecipeManager();

  Future<double> calculateRating() async {
    final highestRating = await recipeManager.getHighestRecipeRating();
    return widget.recipeTimesFavorited / (highestRating ?? 1) * 5;
  }

  @override
  void initState() {
    super.initState();
    _fetchRating();
  }

  Future<void> _fetchRating() async {
    final highestRating = await recipeManager.getHighestRecipeRating();
    if (mounted) {
      // Check if the widget is still in the widget tree
      setState(() {
        rating = widget.recipeTimesFavorited / (highestRating ?? 1) * 5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Recipe recipe = Recipe(
            recipeDescription: widget.recipeDescription,
            recipeDifficulty: widget.recipeDifficulty,
            recipeImageUrl: widget.recipeImage,
            recipeInstructions: widget.recipeInstructions,
            recipePreparation: widget.recipePreparation,
            recipeOwner: widget.recipeOwner,
            recipeName: widget.recipeName,
            recipeTimesFavorited: widget.recipeTimesFavorited,
            recipeId: widget.recipeId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeScreen(recipe: recipe)));
      },
      child: Material(
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: double.infinity, // your desired width
                height: 240, // your desired height
                child: ClipRect(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: widget.recipeImage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "User: yamankwefati",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                              text: 'Time: ${widget.recipeDifficulty} m',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              )),
                          WidgetSpan(
                            baseline: TextBaseline.alphabetic,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Icon(
                                Icons.timer,
                                color: Colors.black,
                                size:
                                    20.0, // You might want to adjust this size as needed
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Text("${widget.recipeDescription}"),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rating:'),
                  IgnorePointer(
                    child: RatingBar.builder(
                      itemSize: 25.0,
                      updateOnDrag: false,
                      initialRating: rating ?? 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (v) {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        color: Color(0xFFF4F7F9),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
