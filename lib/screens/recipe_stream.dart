import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_it/screens_components/recipe_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

final db = FirebaseFirestore.instance;
final storageRef = FirebaseStorage.instance.ref();
final auth = FirebaseAuth.instance;

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
    return StreamBuilder<DocumentSnapshot>(
      stream: db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("favoritedrecipes")
          .doc("recipes")
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          List<String> favoritedRecipesIds =
              List<String>.from(data['recipes'] ?? []);

          return FutureBuilder<QuerySnapshot>(
            future: db
                .collection("recipes")
                .where(FieldPath.documentId, whereIn: favoritedRecipesIds)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text("No favorite recipes found.");
              }

              List<Widget> recipeWidgets = [];
              for (var recipe in snapshot.data!.docs) {
                final recipeData = recipe.data() as Map<String, dynamic>;
                // Extract recipe details
                final recipeDescription = recipeData["description"];
                final recipeDifficulty = recipeData["difficulty"];
                final recipeTimesFavorited = recipeData["favorited"];
                final recipeImageUrl = recipeData["imageUrl"];
                final recipeImage = Image.network(recipeImageUrl);
                final recipeInstructions = recipeData["instructions"];
                final recipeName = recipeData["name"];
                final recipePreparation = recipeData["preparation"];
                final recipeOwner = recipeData["owner"];

                final recipePost = FavoriteRecipePost(
                  recipeDescription: recipeDescription,
                  recipeDifficulty: recipeDifficulty,
                  recipeTimesFavorited: recipeTimesFavorited,
                  recipeImage: recipeImage,
                  recipeInstructions: recipeInstructions,
                  recipeName: recipeName,
                  recipePreparation: recipePreparation,
                  recipeOwner: recipeOwner,
                );
                recipeWidgets
                  ..add(recipePost)
                  ..add(SizedBox(height: 10.0));
              }

              return ListView(children: recipeWidgets);
            },
          );
        }
        return Text('Unknown state');
      },
    );
  }
}
