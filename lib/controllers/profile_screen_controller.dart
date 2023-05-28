import 'package:flutter/material.dart';
import '../models/profile_screen_model.dart';

class ProfileScreenController {
  final ProfileScreenModel _model = ProfileScreenModel();

  String get title => _model.title;

  Color get color => _model.color;

  double get fontSize => _model.fontSize;

  FontWeight get fontWeight => _model.fontWeight;
}
