import 'package:flutter/material.dart';
import '../../../app_colors.dart';
import '../../../controllers/widget_button_controller.dart';

/// Hier sollte man für Widgets weiter entwickeln
class WidgetButton extends StatelessWidget {
  final String? title;
  final Color backgroundColor;
  final Color textColor;
  final Widget targetPage;
  final bool isLarge;
  final Widget? icon;

  final WidgetButtonController _controller = WidgetButtonController();

  WidgetButton({
    Key? key,
    required this.title,
    this.backgroundColor = AppColors.fhwaveBlue500,
    this.textColor = Colors.black,
    required this.targetPage,
    this.isLarge = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.85;
    final buttonWidth = isLarge ? containerWidth : (containerWidth - 12) / 2;
    const height = 130.0;

    return SizedBox(
      width: buttonWidth,
      height: height,
      child: GestureDetector(
        onTap: () => _controller.navigateToPage(context, targetPage),
        child: Container(
          width: buttonWidth,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Center(
                    child: icon!,
                  ),
                const SizedBox(height: 8),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
