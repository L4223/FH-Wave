import 'package:flutter/material.dart';

const backgroundColor = Colors.black12;

void ChangeBackground() {
  if (backgroundColor == Colors.white) {
    backgroundColor == Colors.black12;
  } else {
    backgroundColor == Colors.white;
  }
  print('drücken');
}

Widget DarkModeButton() {
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
