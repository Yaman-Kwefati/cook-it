import 'package:cook_it/screens/add_recipe_screen.dart';
import 'package:cook_it/screens_constants.dart';
import 'package:flutter/material.dart';

class HomeScreenFloationAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AddRecipeScreen.id);
        });
  }
}
