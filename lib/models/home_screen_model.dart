import 'package:flutter/material.dart';

class HomeScreenModel {
  final String _greeting = 'Moin';
  final String _name = 'Mustermann';
  final String _motivatingWords = 'Bist du voll motiviert?';
  final Color _fontColor = Colors.black;

  String get greeting => _greeting;

  String get name => _name;

  String get motivatingWords => _motivatingWords;

  Color get fontColor => _fontColor;
}
