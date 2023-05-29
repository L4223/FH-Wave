import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/dark_mode_controller.dart';

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(const Size(50, 50)),
          maximumSize: MaterialStateProperty.all(const Size(50, 50)),
          side: MaterialStateProperty.all(
            const BorderSide(width: 2, color: Colors.black),
          ),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: () {
          controller.toggleDarkMode();
        },
        child: Text(controller.isDarkMode ? 'DarkMode' : 'LightMode'),
      );
    });
  }
}
