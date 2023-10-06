import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_it/screens_components/recipe_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

final db = FirebaseFirestore.instance;
final storageRef = FirebaseStorage.instance.ref();
late User loggedInUser;

class RecipesStream extends StatelessWidget {
  final imagesRef = storageRef.child("recipes/images/image.jpeg");

  dynamic getImage() async {
    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await imagesRef.getData(oneMegabyte);
    } catch (e) {
      if (e == MissingPluginException) {
        print(MissingPluginException().message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection("recipes").snapshots(),
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
          List<RecipePost> recipePosts = [];
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
            final recipePost = RecipePost(
              recipeDescription: recipeDescription,
              recipeDifficulty: recipeDifficulty,
              recipeTimesFavorited: recipeTimesFavorited,
              recipeImage: recipeImage,
              recipeInstructions: recipeInstructions,
              recipeName: recipeName,
              recipePreparation: recipePreparation,
              recipeOwner: recipeOwner,
            );
            recipePosts.add(recipePost);
          }
          return ListView(
            children: recipePosts,
          );
        }
        return Text('Unknown state');
      },
    );
  }
}
