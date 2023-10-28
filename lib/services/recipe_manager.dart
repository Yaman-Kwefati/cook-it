import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeManager {
  final db = FirebaseFirestore.instance;

  Future<void> updatePopularRecipes() async {
    QuerySnapshot snapshot = await db
        .collection('recipes')
        .orderBy('favorited', descending: true)
        .limit(5)
        .get();

    for (var doc in snapshot.docs) {
      await db
          .collection('popularRecipes')
          .doc(doc.id)
          .set(doc.data() as Map<String, dynamic>? ?? {});
    }
  }

  Future<double?> getHighestRecipeRating() async {
    QuerySnapshot snapshot = await db
        .collection('recipes')
        .orderBy('favorited', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;

    Map<String, dynamic> highestRatedRecipeData =
        snapshot.docs.first.data() as Map<String, dynamic>;

    return highestRatedRecipeData['favorited']?.toDouble();
  }
}
