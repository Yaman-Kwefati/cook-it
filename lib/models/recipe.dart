class Recipe {
  final recipeId;
  final recipeDescription;
  final recipeDifficulty;
  final recipeTimesFavorited;
  final recipeImageUrl;
  final recipeImage;
  final recipeInstructions;
  final recipeName;
  final recipePreparation;
  final recipeOwner;

  Recipe({
    this.recipeId,
    this.recipeDescription,
    this.recipeDifficulty,
    this.recipeTimesFavorited,
    this.recipeImageUrl,
    this.recipeImage,
    this.recipeInstructions,
    this.recipeName,
    this.recipePreparation,
    this.recipeOwner,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      recipeDescription: map['recipeDescription'],
      recipeDifficulty: map['recipeDifficulty'],
      recipeTimesFavorited: map['recipeTimesFavorited'],
      recipeImageUrl: map['recipeImageUrl'],
      recipeImage: map['recipeImage'],
      recipeInstructions: map['recipeInstructions'],
      recipeName: map['recipeName'],
      recipePreparation: map['recipePreparation'],
      recipeOwner: map['recipeOwner'],
    );
  }
}
