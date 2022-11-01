import 'package:flutter/material.dart';

TextStyle titleTextStyle(
    {double fontSize = 25,
    Color color = Colors.black,
    required BuildContext context}) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.bodyText1!.color,
      letterSpacing: 1.8);
}