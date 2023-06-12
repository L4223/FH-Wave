import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_colors.dart';
import '../../controllers/dark_mode_controller.dart';

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 150;
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(width, 50)),
            maximumSize: MaterialStateProperty.all(Size(width, 50)),
            side: MaterialStateProperty.all(
              const BorderSide(width: 2, color: Colors.black),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: () {
            controller.toggleDarkMode();
          },
          child: Text(controller.isDarkMode ? 'LightMode' : 'DarkMode',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700, // Schriftgewicht des Buttons
              )));
    });
  }
}
