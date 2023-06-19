import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app_colors.dart';
import '../../../controllers/dark_mode_controller.dart';

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
      calculatedWidth = MediaQuery
          .of(context)
          .size
          .width - 150;
    }

    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: calculatedWidth,
          height: height,
          decoration: BoxDecoration(
            color: controller.isDarkMode
                ? AppColors.fhwaveNeutral600
                : AppColors.white,
            // Hintergrundfarbe des Buttons
            borderRadius: BorderRadius.circular(height / 2),
            // Randradius des Buttons
            border: Border.all(
                width: 2.0,
                color: controller.isDarkMode ?
                AppColors.fhwaveNeutral600 : AppColors
                    .black // Randdicke des Buttons
            ),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: controller.isDarkMode
                    ? AppColors.white
                    : AppColors.black, // Textfarbe des Buttons
                fontSize: 18,
                fontWeight: FontWeight.w700, // Schriftgewicht des Buttons
              ),
            ),
          ),
        ),
      );
    });
  }
}
