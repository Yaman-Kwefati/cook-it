import 'package:cook_it/screens/add_recipe_screen.dart';
import 'package:cook_it/screens/category_recipes_screen.dart';
import 'package:cook_it/screens/login_screen.dart';
import 'package:cook_it/screens/main_screen.dart';
import 'package:cook_it/screens/recipe_screen.dart';
import 'package:cook_it/screens/registration_screen.dart';
import 'package:cook_it/screens/welcome_screen.dart';
import 'package:cook_it/screens_components/categories_listview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(CookIt());
}

class CookIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: <String, WidgetBuilder>{
        WelcomeScreen.id: (BuildContext context) => WelcomeScreen(),
        MainScreen.id: (BuildContext context) => MainScreen(),
        // RecipeScreen.id: (BuildContext context) => RecipeScreen(),
        CategoryRecipesScreen.id: (BuildContext context) =>
            CategoryRecipesScreen(),
        LoginScreen.id: (BuildContext context) => LoginScreen(),
        RegistrationScreen.id: (BuildContext context) => RegistrationScreen(),
        AddRecipeScreen.id: (BuildContext context) => AddRecipeScreen(),
      },
    );
  }
}
