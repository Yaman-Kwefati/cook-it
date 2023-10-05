import 'package:flutter/material.dart';

class HomeScreenFloationAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 65.0),
      child: FloatingActionButton(
          backgroundColor: Color(0xFF0F2C59),
          child: Icon(
            Icons.add,
            size: 40.0,
          ),
          onPressed: () {}),
    );
  }
}
