import 'package:cook_it/screens_components/home_text_row.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "home_screen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Material(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image(
                                    image: AssetImage('images/test-image.png')),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "User: yamankwefati",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        children: [
                                          TextSpan(
                                              text: 'Time: ',
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
                                Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Rating:'),
                                    IgnorePointer(
                                      child: RatingBar.builder(
                                        itemSize: 25.0,
                                        updateOnDrag: false,
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
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
                        Material(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image(
                                    image: AssetImage('images/test-image.png')),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "User: yamankwefati",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        children: [
                                          TextSpan(
                                              text: 'Time: ',
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
                                Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Rating:'),
                                    IgnorePointer(
                                      child: RatingBar.builder(
                                        itemSize: 25.0,
                                        updateOnDrag: false,
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
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
                      ],
                    ),
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
