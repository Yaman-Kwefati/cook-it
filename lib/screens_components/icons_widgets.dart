import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeartIconButton extends StatefulWidget {
  @override
  _HeartIconButtonState createState() => _HeartIconButtonState();
}

class _HeartIconButtonState extends State<HeartIconButton> {
  Color iconColor = Colors.black;
  IconData icon = CupertinoIcons.heart;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        child: Icon(icon, color: iconColor),
        backgroundColor: CupertinoColors.systemGrey6,
      ),
      onPressed: () {
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
