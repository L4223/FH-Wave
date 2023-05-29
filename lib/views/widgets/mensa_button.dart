import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri mensaURL = Uri.parse(
    'https://studentenwerk.sh/de/mensen-in-kiel?ort=1&mensa=5#mensaplan'); //Link of the Website

Widget mensaButton() {
  return OutlinedButton(
    style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0), // Rounding the Edges
          ),
        ),
        maximumSize: MaterialStateProperty.all(const Size(200, 50)),
        minimumSize: MaterialStateProperty.all(const Size(200, 50)),
        side: MaterialStateProperty.all(
            const BorderSide(width: 2, color: Colors.black)),
        // Border-settings
        foregroundColor: MaterialStateProperty.all(Colors.black)),
    onPressed: _launchUrl,
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center, // Icon & Text of the Button
      children: [
        Icon(Icons.food_bank_outlined),
        SizedBox(width: 2),
        Text('Mensa'),
      ],
    ),
  );
}

Future<void> _launchUrl() async {
  //Function to open the Window
  if (!await launchUrl(mensaURL)) {
    throw Exception('Could not launch $mensaURL');
  }
}
