import 'package:flutter/material.dart';
import '../../../app_colors.dart';

/// fhwave-Primary-Button-With-Icon ist ein primärer Button-Stil mit einem Icon.
/// Hauptsächlich zur besseren visuellen Darstellung des Zwecks
/// der Button verwendet. Hier sind eine Beispiel für die Einsatzung:
/// "+ Hinzufügen"
class PrimaryButtonWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final double width;
  final double height;
  final VoidCallback onTap;

  const PrimaryButtonWithIcon({
    Key? key,
    required this.text,
    required this.icon,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var calculatedWidth = width;

    if (width == double.infinity) {
      calculatedWidth = MediaQuery.of(context).size.width - 150;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: calculatedWidth,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.black,
          // Hintergrundfarbe des Buttons
          borderRadius: BorderRadius.circular(height / 2),
          // Randradius des Buttons
          border: Border.all(
            width: 2.0, // Randdicke des Buttons
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 25,
                color: AppColors.white, // Farbe des Icons
              ),
              const SizedBox(width: 4.0), // Abstand zwischen Icon und Text
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.white, // Textfarbe des Buttons
                  fontSize: 16,
                  fontWeight: FontWeight.w700, // Schriftgewicht des Buttons
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
