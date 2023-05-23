import 'package:flutter/material.dart';
import '../models/home_screen_model.dart';

class HomeScreenController {
  final HomeScreenModel _model = HomeScreenModel();

  String get greeting => _model.greeting;

  String get name => _model.name;

  String get motivatingWords => _model.motivatingWords;

  Color get fontColor => _model.fontColor;
}
