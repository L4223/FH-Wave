import 'package:flutter/material.dart';

Color Hintergrundfarbe = Colors.white;

class DarkMode extends StatefulWidget {
  @override
  DarkModeButton createState() => DarkModeButton();
}

class DarkModeButton extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0), // Rounding the Edges
            ),
          ),
          minimumSize: MaterialStateProperty.all(const Size(200, 50)),
          maximumSize: MaterialStateProperty.all(const Size(300, 50)),
          side: MaterialStateProperty.all(
              const BorderSide(width: 2, color: Colors.black)),
          // Border-settings
          foregroundColor: MaterialStateProperty.all(Colors.black)),
      onPressed: ChangeBackground,
      child: Icon(Icons.abc),
    );
  }

  void ChangeBackground() {
    setState(() {
      Hintergrundfarbe =
          Hintergrundfarbe == Colors.white ? Color(0xFF696969) : Colors.white;
      print(Hintergrundfarbe);
    });
  }
}
