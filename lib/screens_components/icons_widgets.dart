import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeartIconButton extends StatefulWidget {
  final String recipeId;

  HeartIconButton({required this.recipeId});
  @override
  _HeartIconButtonState createState() => _HeartIconButtonState();
}

class _HeartIconButtonState extends State<HeartIconButton> {
  Color iconColor = Colors.black;
  IconData icon = CupertinoIcons.heart;
  final db = FirebaseFirestore.instance;

  Future<void> _toggleFavorite(String recipeId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = db.collection('users').doc(userId);
    final recipeRef = userDoc.collection('favoritedrecipes').doc('recipes');

    final doc = await recipeRef.get();
    if (doc.exists) {
      List<String> favoritedRecipes =
          List<String>.from(doc.data()?['recipes'] ?? []);

      final recipeDoc = await db.collection("recipes").doc(recipeId).get();
      var currentCount = recipeDoc.data()?['favorited'] ?? 0;

      if (favoritedRecipes.contains(recipeId)) {
        favoritedRecipes.remove(recipeId);
        if (currentCount > 0) {
          currentCount -= 1.0;
        }
        db
            .collection("recipes")
            .doc(recipeId)
            .set({'favorited': currentCount}, SetOptions(merge: true));
      } else {
        favoritedRecipes.add(recipeId);
        currentCount += 1.0;
        db
            .collection("recipes")
            .doc(recipeId)
            .set({'favorited': currentCount}, SetOptions(merge: true));
      }

      await recipeRef.set({'recipes': favoritedRecipes});
    } else {
      await recipeRef.set({
        'recipes': [recipeId]
      });
    }
  }

  Future<void> _checkIfFavorited() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    final recipeRef = userDoc.collection('favoritedrecipes').doc('recipes');

    final doc = await recipeRef.get();
    if (doc.exists) {
      List<String> favoritedRecipes =
          List<String>.from(doc.data()?['recipes'] ?? []);
      if (favoritedRecipes.contains(widget.recipeId)) {
        setState(() {
          icon = CupertinoIcons.heart_fill;
          iconColor = Colors.red;
        });
      } else {
        setState(() {
          icon = CupertinoIcons.heart;
          iconColor = Colors.black;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfFavorited();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        child: Icon(icon, color: iconColor),
        backgroundColor: CupertinoColors.systemGrey6,
      ),
      onPressed: () async {
        await _toggleFavorite(widget.recipeId);
        setState(() {
          icon = icon == CupertinoIcons.heart
              ? CupertinoIcons.heart_fill
              : CupertinoIcons.heart;
          iconColor = iconColor == Colors.black ? Colors.red : Colors.black;
        });
      },
    );
  }
}
