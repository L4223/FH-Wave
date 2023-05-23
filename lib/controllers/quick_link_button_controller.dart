import 'package:flutter/material.dart';
import '../models/quick_link_button_model.dart';

class QuickLinkButtonController {
  final QuickLinkButtonModel _model = QuickLinkButtonModel();

  Color get color => _model.color;

  void navigateToTargetPage(BuildContext context, Widget targetPage) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }
}
