import 'package:flutter/material.dart';

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
            title,  // Use the title passed in
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Helvetica Neue'
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        // 页面内容
      ),
    );
  }
}
