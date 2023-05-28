import 'package:flutter/material.dart';
import '../models/add_widgets_screen_model.dart';

class AddWidgetsScreenController {
  final AddWidgetsScreenModel _model = AddWidgetsScreenModel();

  String get title => _model.title;

  Color get color => _model.color;

  double get fontSize => _model.fontSize;

  FontWeight get fontWeight => _model.fontWeight;
}
