import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class RecipePost extends StatelessWidget {
  RecipePost(
      {required this.recipeDescription,
      required this.recipeDifficulty,
      required this.recipeTimesFavorited,
      required this.recipeImage,
      required this.recipeInstructions,
      required this.recipeName,
      required this.recipePreparation});

  final recipeDescription;
  final recipeDifficulty;
  final recipeTimesFavorited;
  final recipeImage;
  final recipeInstructions;
  final recipeName;
  final recipePreparation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("recipe clicked");
      },
      child: Material(
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: double.infinity, // your desired width
                height: 240, // your desired height
                child: ClipRect(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: recipeImage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "User: yamankwefati",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                              text: 'Time: $recipeDifficulty m',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              )),
                          WidgetSpan(
                            baseline: TextBaseline.alphabetic,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Icon(
                                Icons.timer,
                                color: Colors.black,
                                size:
                                    20.0, // You might want to adjust this size as needed
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Text("$recipeDescription"),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rating:'),
                  IgnorePointer(
                    child: RatingBar.builder(
                      itemSize: 25.0,
                      updateOnDrag: false,
                      initialRating: recipeTimesFavorited,
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
              )
            ],
          ),
        ),
        color: Color(0xFFF4F7F9),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
