import 'package:flutter/material.dart';

/// Hier ist nur eine Template für Screens, die ohne ausgefallenen Dekorationen
class TemplateScreen extends StatelessWidget {
  final String title;

  /// Man kann title für das Screen bei Verwendung dieses Screens eingeben
  const TemplateScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: 100,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Helvetica Neue'),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(),
    );
  }
}
