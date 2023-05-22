import 'package:flutter/material.dart';

class AddWidgetsScreen extends StatelessWidget {
  const AddWidgetsScreen({Key? key}) : super(key: key);

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
            'Widgets',
            style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Helvetica Neue'),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
      ),
    );
  }
}
