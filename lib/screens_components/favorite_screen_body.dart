import 'package:cook_it/screens/recipe_stream.dart';
import 'package:flutter/material.dart';

class FavoriteSreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Expanded(
            flex: 18,
            child: RecipesStream(),
          ),
        ],
      ),
    );
  }
}
