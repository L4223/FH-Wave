import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'add_widgets_screen.dart';
import 'build_widget_button.dart';
import 'template_screen.dart';

Widget meineWidgetsScreen(BuildContext context) {
  return Wrap(
    direction: Axis.horizontal,
    spacing: 17,
    runSpacing: 17,
    children: [
      buildWidgetButton(
        context,
        title: 'TEMPLATE WIDGET',
        backgroundColor: AppColors.appBlue,
        targetPage: const TemplateScreen(
          title: 'TEMPLATE1',
        ),
      ),
      buildWidgetButton(
        context,
        title: 'TEMPLATE WIDGET',
        backgroundColor: AppColors.appPurple,
        targetPage: const TemplateScreen(title: 'TEMPLATE2'),
      ),
      buildWidgetButton(context,
          title: 'TEMPLATE WIDGET',
          backgroundColor: AppColors.appYellow,
          targetPage: const TemplateScreen(title: 'TEMPLATE3'),
          isLarge: true),

      /// Add widgets here. Attention: Just above not after the Center below!
      Center(
        child: ClipOval(
          child: Container(
            color: Colors.black,
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddWidgetsScreen()),
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
