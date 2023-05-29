import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'add_widgets_screen.dart';
import 'group_screens/group_screen.dart';
import 'template_screen.dart';
import 'widgets/widget_button.dart';

Widget meineWidgetsScreen(BuildContext context) {
  return Wrap(
    direction: Axis.horizontal,
    alignment: WrapAlignment.center,
    spacing: 12,
    runSpacing: 12,
    children: [
      /// Hier sind nur Beispiele, biite modifizieren oder ersetzen
      WidgetButton(
        title: 'TEMPLATE WIDGET',
        backgroundColor: AppColors.appBlue,
        targetPage: TemplateScreen(),
      ),
      WidgetButton(
        title: 'Gruppen',
        backgroundColor: AppColors.appPurple,
        targetPage: const GroupCreationScreen(),
      ),
      WidgetButton(
          title: 'TEMPLATE WIDGET',
          backgroundColor: AppColors.appYellow,
          targetPage: TemplateScreen(),
          isLarge: true),

      /// Widgets hier hinzufügen.
      /// Achtung! Nur oben, nicht nach dem Center unten!
      Center(
        child: ClipOval(
          child: Container(
            color: Colors.black,
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddWidgetsScreen()),
                );
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ),
        ),
      ),
    ],
  );
}
