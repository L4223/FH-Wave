import 'package:flutter/material.dart';
import '../app_colors.dart';

Widget buildWidgetButton(
  BuildContext context, {
  String? title,
  Color backgroundColor = AppColors.appBlue,
  Color textColor = Colors.black,
  required Widget targetPage,
  bool isLarge = false,
}) {
  final width = isLarge ? 338.0 : 160.0;
  const height = 112.0;

  void navigateToTargetPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  return SizedBox(
    width: width,
    height: height,
    child: GestureDetector(
      onTap: navigateToTargetPage,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Helvetica Neue',
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
