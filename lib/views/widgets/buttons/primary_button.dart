import 'package:flutter/material.dart';
import '../../../app_colors.dart';

/// fhwave-Primary-Button ist ein primärer Button-Stil.Hier sind einige
/// Beispiele für die Einsatzung:
/// Aktionen mit höherer Priorität.
/// Bestimmte Aktivitäten, zu denen Wir den Nutzer veranlassen möchten
///
/// "Bestätigen", "Löschen", "Speichern","Weiter", "Anmelden" usw.
class PrimaryButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback onTap;

  const PrimaryButton({
    Key? key,
    required this.text,
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
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.white, // Textfarbe des Buttons
              fontSize: 18,
              fontWeight: FontWeight.w700, // Schriftgewicht des Buttons
            ),
          ),
        ),
      ),
    );
  }
}
