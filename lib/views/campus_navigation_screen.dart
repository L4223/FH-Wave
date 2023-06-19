import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../views/building_plan_widget.dart';
import 'widgets/group_widgets/appbar.dart';

/// Hier ist nur eine Template für Screens, die ohne ausgefallenen Dekorationen
/// Bitte kopierst du hier den Code, um neues Screen zu erstellen
/// Beahctet du die Erstellung von entsprechenden Model und Controller
class CampusNavagationScreen extends StatelessWidget {
  const CampusNavagationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      AppColors.getFhwaveBlueGradientContainer(context),
      SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 70,
          ),
          TransparentAppbar(
            heading: "Campus Navigation",
            route: "/home",
          ),
          const SizedBox(
            height: 50,
          ),
          const BuildingPlanWidget(),
        ]),
      ),
    ]));
  }
}
