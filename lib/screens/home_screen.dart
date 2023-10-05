import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_it/screens_components/home_screen_floation_action_button.dart';
import 'package:cook_it/screens_components/home_text_row.dart';
import 'package:cook_it/screens_components/recipe_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

final db = FirebaseFirestore.instance;
final storageRef = FirebaseStorage.instance.ref();
late User loggedInUser;

class HomeScreen extends StatefulWidget {
  static final String id = "home_screen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: HomeScreenFloationAction(),
      appBar: AppBar(
        title: Text(
          "CookIt",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        shadowColor: Colors.white,
        backgroundColor: Color(0xFFFFFFFF),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
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
            ),
          ),
          Container(
            height: 90.0,
            decoration: BoxDecoration(
              color: Color(0xFF0F2C59),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF0F2C59),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Color(0xFF0F2C59),
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ), //BoxShadow
              ],
            ),
          )
        ],
      ),
    );
  }
}

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
            final recipePost = RecipePost(
                recipeDescription: recipeDescription,
                recipeDifficulty: recipeDifficulty,
                recipeTimesFavorited: recipeTimesFavorited,
                recipeImage: recipeImage,
                recipeInstructions: recipeInstructions,
                recipeName: recipeName,
                recipePreparation: recipePreparation);
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
