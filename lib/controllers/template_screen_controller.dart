import 'package:flutter/material.dart';
import '../models/template_screen_model.dart';

class TemplateScreenController {
  final TemplateScreenModel _model = TemplateScreenModel();

  String get title => _model.title;

  Color get color => _model.color;

  double get fontSize => _model.fontSize;

  FontWeight get fontWeight => _model.fontWeight;
}
