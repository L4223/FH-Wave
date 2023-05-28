import 'package:flutter/material.dart';

Color hintergrundfarbe = Colors.white;

class DarkMode extends StatefulWidget {
  final Function(Color) updateBackgroundColor; // Callback-Funktion definieren

  const DarkMode(this.updateBackgroundColor, {Key? key}) : super(key: key);

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
      onPressed: changeBackground,
      child: Text(hintergrundfarbe.toString()),
    );
  }

  void changeBackground() {
    setState(() {
      widget.updateBackgroundColor(
        hintergrundfarbe == Colors.white
            ? const Color(0xFF696969)
            : Colors.white,
      );
    });
  }
}
