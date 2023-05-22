import 'package:flutter/material.dart';
import 'build_widget_button.dart';
import 'template_screen.dart';
import '../app_colors.dart';

Widget MeineWidgetsScreen(BuildContext context) {
  return Wrap(
    direction: Axis.horizontal,
    spacing: 17,
    runSpacing: 17,
    children: [
      buildWidgetButton(
        context,
        title: 'TEMPLATE WIDGET',
        backgroundColor: AppColors.appBlue,
        targetPage: TemplateScreen(
          title: 'TEMPLATE1',
        ),
      ),
      buildWidgetButton(
        context,
        title: 'TEMPLATE WIDGET',
        backgroundColor: AppColors.appPurple,
        targetPage: TemplateScreen(title: 'TEMPLATE2'),
      ),
      buildWidgetButton(context,
          title: 'TEMPLATE WIDGET',
          backgroundColor: AppColors.appYellow,
          targetPage: TemplateScreen(title: 'TEMPLATE3'),
          isLarge: true),
      Center(
        child: ClipOval(
          child: Container(
            color: Colors.black,
            child: IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {},
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ),
        ),
      ),
    ],
  );
}
