import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_colors.dart';
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 60,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Wo willst du hin?',
              style: TextStyle(
                color: controller.isDarkMode ? Colors.black : Colors.black,
                fontSize: _controller.fontSize,
                fontWeight: _controller.fontWeight,
              ),
            ),
          ),
          iconTheme: IconThemeData(
              color: controller.isDarkMode ? Colors.black : Colors.black),
        ),
        body: Container(
            decoration:
                const BoxDecoration(gradient: AppColors.fhwaveBlueGradient),
            child: const BuildingPlanWidget()),
      );
    });
  }
}
