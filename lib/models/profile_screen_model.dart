import 'package:flutter/material.dart';

class ProfileScreenModel {
  final String _title = 'Profile';
  final Color _color = Colors.black;
  final double _fontSize = 28.0;
  final FontWeight _fontWeight = FontWeight.w700;

  String get title => _title;

  Color get color => _color;

  double get fontSize => _fontSize;

  FontWeight get fontWeight => _fontWeight;
}
