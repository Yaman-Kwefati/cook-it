import 'package:cook_it/screens_components/home_text_row.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            HomeTextRow(
              text: 'Category',
              function: () {},
            ),
            HomeTextRow(
              text: 'Populare Recepies',
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}
