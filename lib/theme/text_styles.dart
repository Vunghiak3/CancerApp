import 'package:flutter/material.dart';

class AppTextStyles{
  static const double sizeContent = 14;
  static const double sizeSubtitle = 12;
  static const double sizeTitle = 18;
  static const double sizeIcon = 24;
  static const double sizeIconSmall = 18;
  static const TextStyle content = TextStyle(fontSize: sizeContent, color: Colors.black, fontWeight: FontWeight.normal);
  static const TextStyle subtitle = TextStyle(fontSize: sizeSubtitle, color: Colors.grey, fontWeight: FontWeight.normal);
  static const TextStyle title = TextStyle(fontSize: sizeTitle, color: Colors.black, fontWeight: FontWeight.w500);

  // button dialog
  static const TextStyle delete = TextStyle(fontSize: sizeContent, color: Colors.red, fontWeight: FontWeight.normal);
  static const TextStyle cancel = TextStyle(fontSize: sizeContent, fontWeight: FontWeight.normal);
}