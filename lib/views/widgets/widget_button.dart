import 'package:flutter/material.dart';
import '../../app_colors.dart';
import '../../controllers/widget_button_controller.dart';

/// Hier sollte man für Widgets weiter entwickeln
class WidgetButton extends StatelessWidget {
  final String? title;
  final Color backgroundColor;
  final Color textColor;
  final Widget targetPage;
  final bool isLarge;
  final Widget? icon;

  final WidgetButtonController _controller = WidgetButtonController();

  WidgetButton({super.key,
    required this.title,
    this.backgroundColor = AppColors.fhwaveBlue500,
    this.textColor = Colors.black,
    required this.targetPage,
    this.isLarge = false,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width = isLarge ? screenWidth * 0.9 : screenWidth * 0.41;
    const height = 130.0;

    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTap: () => _controller.navigateToPage(context, targetPage),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                if (icon != null)
                  Center(
                    child:icon!
                  ),
          const SizedBox(height: 8),
                Text(title!,
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









