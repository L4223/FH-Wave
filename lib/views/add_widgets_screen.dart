import 'package:flutter/material.dart';
import '../controllers/add_widgets_screen_controller.dart';

/// Hier kann man für AddWidgetsScreen weiter entwickeln
class AddWidgetsScreen extends StatelessWidget {
  AddWidgetsScreen({Key? key}) : super(key: key);
  final AddWidgetsScreenController _controller = AddWidgetsScreenController();

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
            _controller.title,
            style: TextStyle(
              color: _controller.color,
              fontSize: _controller.fontSize,
              fontWeight: _controller.fontWeight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body:

          /// Hier schreibst du deine Code
          /// und bitte vergisst du noch MVC-Design-Pattern
          Container(),
    );
  }
}
