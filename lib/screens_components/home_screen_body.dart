import 'package:cook_it/screens/recipe_stream.dart';
import 'package:cook_it/screens_components/home_text_row.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          HomeTextRow(
            text: 'Category',
            function: () {},
          ),
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  child: Material(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "🥞Breakfast",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    color: Color(0xFFF4F7F9),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onTap: () {
                    print("tapped");
                  },
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          HomeTextRow(
            text: 'Popular Recipes',
            function: () {},
          ),
          Expanded(
            flex: 18,
            child: RecipesStream(),
          ),
        ],
      ),
    );
  }
}
