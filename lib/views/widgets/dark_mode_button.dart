import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/dark_mode_controller.dart';

Color hintergrundfarbe = Colors.white;

/*
class DarkMode extends StatefulWidget {
  final Function(Color) updateBackgroundColor; // Callback-function

  const DarkMode(this.updateBackgroundColor, {Key? key}) : super(key: key);

  @override
  DarkModeButton createState() => DarkModeButton();
}
*/
class DarkModeButton extends StatelessWidget {
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
          minimumSize: MaterialStateProperty.all(const Size(200, 50)),
          maximumSize: MaterialStateProperty.all(const Size(300, 50)),
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
