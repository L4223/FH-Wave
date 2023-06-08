import 'package:flutter/material.dart';
import '../../../app_colors.dart';

/// fhwave-Secondary-Button ist ein Wireframe sekundärer Button-Stil.
/// Beispiele für die Einsatzung:
/// Bei Sekundärer Optionen/ Alternativer Aktionen.
/// Bei zwei Aktionen mit unterschiedlicher Priorität.
///
/// "Abbrechen". Auchte darauf, dass "Abbrechen" auch Prämier Button sein kann,
/// wenn wir den Nutzer zu "Abbrechen" veranlassen möchten, um Fehlbedienung
/// zu verhindern. z.B. bei dem Löschen/Auflösen der Gruppe.
class SecondaryButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback onTap;

  const SecondaryButton({
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
          color: AppColors.transparent,
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
              color: AppColors.black, // Textfarbe des Buttons
              fontSize: 18,
              fontWeight: FontWeight.w700, // Schriftgewicht des Buttons
            ),
          ),
        ),
      ),
    );
  }
}
