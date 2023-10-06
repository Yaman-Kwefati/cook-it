import 'package:cook_it/screens_components/icons_widgets.dart';
import 'package:cook_it/screens_constants.dart';
import 'package:flutter/cupertino.dart';
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
      required this.recipePreparation,
      required this.recipeOwner});

  final recipeDescription;
  final recipeDifficulty;
  final recipeTimesFavorited;
  final recipeImage;
  final recipeInstructions;
  final recipeName;
  final recipePreparation;
  final recipeOwner;

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
            topBarTitle: Text(recipeName,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                )),
            isTopBarLayerAlwaysVisible: true,
            leadingNavBarWidget: HeartIconButton(),
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
                        child: recipeImage,
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
                          Text("Owner:"),
                          Text("$recipeOwner"),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        recipeDescription,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle the "Cook it" button tap
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
