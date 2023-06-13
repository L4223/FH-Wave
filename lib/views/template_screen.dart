import 'package:flutter/material.dart';

import '../app_colors.dart';
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
  return Scaffold(
  appBar: PreferredSize(
  preferredSize: const Size.fromHeight(100),
  child: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  flexibleSpace: Container(
  decoration: const BoxDecoration(
  gradient: AppColors.fhwaveBlueGradient,
  ),
  ),
  title: Align(
  alignment: Alignment.centerLeft,
  child: Text(
  'Wo willst du hin?',
  style: TextStyle(
  color: AppColors.black,
  fontSize: _controller.fontSize,
  fontWeight: _controller.fontWeight,
  ),
  ),
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  ),
  ),
  body: const BuildingPlanWidget(),
  );
  }
  }