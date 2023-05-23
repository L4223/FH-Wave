import 'package:flutter/material.dart';

/// An example for you. When you create new screen, you use this template
class TemplateScreen extends StatelessWidget {
  final String title;

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
