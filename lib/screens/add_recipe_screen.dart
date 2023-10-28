import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_it/screens_components/picker.dart';
import 'package:cook_it/screens_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddRecipeScreen extends StatefulWidget {
  static final id = "add_recipe_screen";
  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  File? _image;
  List<String> _instructions = [];
  List<String> _preparations = [];
  String? recipeName;
  String? recipeDescription;
  int? recipeDifficulty;
  String? recipeOwner;
  String? imageUrl;
  double? recipeFavorited;
  String? userId;
  String? recipeCategory;

  Future<String> getCurrentUserName() async {
    final user = db.collection("users").doc(auth.currentUser!.uid);
    try {
      DocumentSnapshot doc = await user.get();
      final data = doc.data() as Map<String, dynamic>;
      final firstName = data["firstname"];
      final lastName = data["lastname"];
      return "$firstName $lastName";
    } catch (e) {
      print("Error getting document: $e");
      return "Error fetching name";
    }
  }

  Future<void> uploadImage() async {
    if (_image != null) {
      final String imageId = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = storage.ref().child('recipes/images/$imageId');
      try {
        await ref.putFile(_image!);
        final String downloadURL = await ref.getDownloadURL();
        setState(() {
          imageUrl = downloadURL;
        });
      } catch (e) {
        print("Failed to upload image: $e");
        // Handle the error appropriately.
      }
    }
  }

  void addRecipeToFireBase() async {
    recipeFavorited = 0.0;

    recipeOwner = await getCurrentUserName();

    final recipe = <String, dynamic>{
      "name": recipeName,
      "description": recipeDescription,
      "favorited": recipeFavorited,
      "imageUrl": imageUrl,
      "difficulty": recipeDifficulty,
      "instructions": _instructions,
      "preparation": _preparations,
      "userId": auth.currentUser!.uid,
      "owner": recipeOwner,
      "category": recipeCategory,
    };

    try {
      await db.collection("recipes").add(recipe);
      print("Recipe added successfully.");
    } catch (error) {
      print("Error adding recipe: $error");
    }
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Widget _buildTextField(List<String> list, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: kTextFieldDecoration,
              onChanged: (value) => list[index] = value,
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                list.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  }

  void _addField(List<String> list) {
    setState(() {
      list.add('');
    });
  }

  void handleRecipeUpload() async {
    await uploadImage();
    addRecipeToFireBase();
    Navigator.pop(context);
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return IosPicker(
        onCategorySelected: (selectedCategory) {
          setState(() {
            recipeCategory = selectedCategory;
          });
        },
      );
    } else {
      return AndroidPicker(
        onCategorySelected: (selectedCategory) {
          setState(() {
            recipeCategory = selectedCategory;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Recipe"),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("RecipeName:"),
              TextField(
                onChanged: (value) {
                  recipeName = value;
                },
                decoration: kTextFieldDecoration,
              ),
              SizedBox(height: 10.0),
              Text("Description:"),
              TextField(
                onChanged: (value) {
                  recipeDescription = value;
                },
                decoration: kTextFieldDecoration,
              ),
              SizedBox(height: 10.0),
              Text("Difficulty(in minutes): "),
              TextField(
                onChanged: (value) {
                  recipeDifficulty = int.parse(value);
                },
                decoration: kTextFieldDecoration,
              ),
              SizedBox(height: 10.0),
              Text("Category:"),
              Container(
                child: getPicker(),
              ),
              SizedBox(height: 10.0),
              Text("Image: "),
              if (_image != null) Image.file(_image!),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("Pick an Image"),
              ),
              SizedBox(height: 10.0),
              Text("Instructions: "),
              ..._instructions.asMap().entries.map((entry) {
                int idx = entry.key;
                return _buildTextField(_instructions, idx);
              }).toList(),
              ElevatedButton(
                onPressed: () => _addField(_instructions),
                child: Text("Add Instruction"),
              ),
              SizedBox(height: 10.0),
              Text("Preparations: "),
              ..._preparations.asMap().entries.map((entry) {
                int idx = entry.key;
                return _buildTextField(_preparations, idx);
              }).toList(),
              ElevatedButton(
                onPressed: () => _addField(_preparations),
                child: Text("Add Preparation"),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: handleRecipeUpload,
                child: Text("Cook IT"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
