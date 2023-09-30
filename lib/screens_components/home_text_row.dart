import 'package:flutter/material.dart';

class HomeTextRow extends StatelessWidget {
  HomeTextRow({required this.text, required this.function});
  final String text;
  final VoidCallback? function;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        TextButton(
          onPressed: function,
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                    text: 'View all ',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blueAccent,
                    )),
                WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.blueAccent,
                      size:
                          20.0, // You might want to adjust this size as needed
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
