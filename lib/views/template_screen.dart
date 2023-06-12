import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/dark_mode_controller.dart';
import '../controllers/template_screen_controller.dart';
import '../views/building_plan_widget.dart';

/// Hier ist nur eine Template für Screens, die ohne ausgefallenen Dekorationen
/// Biite kopierst du hier den Code, um neues Screen zu erstellen
/// Beahctet du die Erstellung von entsprechenden Model und Controller
class TemplateScreen extends StatelessWidget {
  TemplateScreen({Key? key}) : super(key: key);
  final TemplateScreenController _controller = TemplateScreenController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          toolbarHeight: 60,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Wo willst du hin?',
              style: TextStyle(
                color: _controller.color,
                fontSize: _controller.fontSize,
                fontWeight: _controller.fontWeight,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: const BuildingPlanWidget(),
      );
    });
  }
}
