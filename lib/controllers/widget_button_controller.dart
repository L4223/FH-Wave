import 'package:flutter/material.dart';

class WidgetButtonController {
  void navigateToPage(BuildContext context, Widget targetPage) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }
}
