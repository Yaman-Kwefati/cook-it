import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_it/models/recipe_data.dart';
import 'package:cook_it/screens/category_recipes_screen.dart';
import 'package:flutter/material.dart';

class CategoriesListView extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  final int? maxCount;
  final Function(String)? onCategorySelected;

  CategoriesListView({this.maxCount, this.onCategorySelected});

  List<Container> buildCategoriesButtons(BuildContext context) {
    List<Container> buttonsList = [];
    int count = 0;
    for (var category in (maxCount != null
        ? categoriesList.take(maxCount!)
        : categoriesList)) {
      Container button = Container(
        margin: EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 5.0), // Adjust as needed
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, CategoryRecipesScreen.id,
                arguments: category);
          },
          child: Text("${emoji[count]} $category"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF6F8FA),
            foregroundColor: Colors.black,
          ),
        ),
      );
      buttonsList.add(button);
      count += 1;
    }
    return buttonsList;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: buildCategoriesButtons(context),
    );
  }
}
