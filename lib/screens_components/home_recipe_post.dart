import 'package:cook_it/models/recipe.dart';
import 'package:cook_it/screens/recipe_screen.dart';
import 'package:cook_it/screens_components/icons_widgets.dart';
import 'package:cook_it/screens_constants.dart';
import 'package:cook_it/services/recipe_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class HomeRecipePost extends StatefulWidget {
  HomeRecipePost(
      {required this.recipeDescription,
      required this.recipeDifficulty,
      required this.recipeTimesFavorited,
      required this.recipeImage,
      required this.recipeInstructions,
      required this.recipeName,
      required this.recipePreparation,
      required this.recipeOwner,
      required this.recipeId});

  final recipeDescription;
  final recipeDifficulty;
  final recipeTimesFavorited;
  final recipeImage;
  final recipeInstructions;
  final recipeName;
  final recipePreparation;
  final recipeOwner;
  final recipeId;

  @override
  State<HomeRecipePost> createState() => _HomeRecipePostState();
}

class _HomeRecipePostState extends State<HomeRecipePost> {
  double? rating;
  final RecipeManager recipeManager = RecipeManager();

  Future<double> calculateRating() async {
    final highestRating = await recipeManager.getHighestRecipeRating();
    return widget.recipeTimesFavorited / (highestRating ?? 1) * 5;
  }

  @override
  void initState() {
    super.initState();
    _fetchRating();
  }

  Future<void> _fetchRating() async {
    final highestRating = await recipeManager.getHighestRecipeRating();
    if (mounted) {
      // Check if the widget is still in the widget tree
      setState(() {
        rating = widget.recipeTimesFavorited / (highestRating ?? 1) * 5;
      });
    }
  }

  void _showModal(BuildContext context) {
    late Color iconColor = Colors.black;
    IconData icon = CupertinoIcons.heart;
    WoltModalSheet.show<void>(
      context: context,
      pageIndexNotifier: ValueNotifier(
          0), // pageIndexNotifier is needed if there are multiple pages in the modal, but you have only one.
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;

        return [
          WoltModalSheetPage.withSingleChild(
            topBarTitle: Text(widget.recipeName,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                )),
            isTopBarLayerAlwaysVisible: true,
            leadingNavBarWidget: HeartIconButton(recipeId: widget.recipeId),
            trailingNavBarWidget: IconButton(
              icon: CircleAvatar(
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                backgroundColor: CupertinoColors.systemGrey6,
              ),
              onPressed: Navigator.of(modalSheetContext).pop,
            ),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 200, // set your desired minimum height
                      maxHeight: MediaQuery.of(context).size.height *
                          0.4, // e.g., 40% of screen height
                    ),
                    child: Hero(
                      tag: 'recipeImageHero',
                      child: FittedBox(
                        child: widget.recipeImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("User: "),
                          Text("${widget.recipeOwner}"),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        widget.recipeDescription,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rating:'),
                      IgnorePointer(
                        child: RatingBar.builder(
                          itemSize: 25.0,
                          updateOnDrag: false,
                          initialRating: rating ?? 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (v) {},
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Recipe recipe = Recipe(
                          recipeDescription: widget.recipeDescription,
                          recipeDifficulty: widget.recipeDifficulty,
                          recipeImageUrl: widget.recipeImage,
                          recipeInstructions: widget.recipeInstructions,
                          recipePreparation: widget.recipePreparation,
                          recipeOwner: widget.recipeOwner,
                          recipeName: widget.recipeName,
                          recipeTimesFavorited: widget.recipeTimesFavorited,
                          recipeId: widget.recipeId);
                      Navigator.of(modalSheetContext).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RecipeScreen(recipe: recipe)));
                    },
                    child: Text('Cook it'),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 25.0),
                      backgroundColor: kPrimaryColor,
                      elevation: 5.0,
                      padding: EdgeInsets.symmetric(horizontal: 75.0),
                    ),
                  ),
                ],
              ),
            ),
          )
        ];
      },
      modalTypeBuilder: (context) {
        // You can set conditions for modal type based on screen size or other factors.
        // For now, I am just returning a bottomSheet type.
        return WoltModalType.bottomSheet;
      },
      onModalDismissedWithBarrierTap: () {
        Navigator.pop(context);
      },
      // Other parameters based on your needs
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showModal(context);
      },
      child: Material(
        elevation: 7.0,
        borderRadius: BorderRadius.circular(5.0),
        color: Color(0xFFF4F7F9),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 85,
                child: widget.recipeImage,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipeName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.recipeDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(), // Apply any style you want
                    ),
                    Text("Read more", style: TextStyle(color: Colors.blue)),
                    SizedBox(height: 5),
                    Text(widget.recipeOwner),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
