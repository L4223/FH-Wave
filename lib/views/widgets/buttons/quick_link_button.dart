import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app_colors.dart';
import '../../../controllers/dark_mode_controller.dart';

/// fhwave-Quick-Link-Button
class QuickLinkButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double width;
  final double height;
  final String url;

  const QuickLinkButton({
    Key? key,
    required this.text,
    required this.icon,
    this.width = double.infinity,
    this.height = 60.0,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var calculatedWidth = width;

    if (width == double.infinity) {
      calculatedWidth = MediaQuery.of(context).size.width - 50;
    }
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return GestureDetector(
        onTap: () async {
          var uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            try {
              await launchUrl(uri);
            } catch (e) {
              throw FlutterError('Could not launch $uri: $e');
            }
          } else {
            throw FlutterError('Could not launch $uri');
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: calculatedWidth,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.transparent, // Hintergrundfarbe des Buttons
            border: Border(
              bottom: BorderSide(
                color:
                    controller.isDarkMode ? AppColors.white : AppColors.black,
                // Farbe der unteren Grenzlinie
                width: 1.0, // Breite der unteren Grenzlinie
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 30,
                      color: controller.isDarkMode
                          ? AppColors.white
                          : AppColors.black, // Farbe des Icons
                    ),
                    const SizedBox(width: 12.0),
                    // Abstand zwischen Icon und Text
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: controller.isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                        // Textfarbe des Buttons
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w500, // Schriftgewicht des Textes
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  size: 35,
                  color: controller.isDarkMode
                      ? AppColors.white
                      : AppColors.black, // Farbe des Rechts-Pfeil-Icons
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
