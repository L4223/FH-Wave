import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


final Uri timetablesURL = Uri.parse(
    'https://www.fh-kiel.de/fachbereiche/informatik-und-elektrotechnik/studiengaenge/uebergreifende-informationen/infos-fuer-studierende/veranstaltungen-sommersemester/'); //Link of the Website


Widget timetablesButton() {
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
        Icon(Icons.calendar_view_week),
        SizedBox(width: 2),
        Text('Stundenpläne'),
      ],
    ),
  );
}

Future<void> _launchUrl() async {
  //Die Webseite wird im default Browser geöffnet
  if (!await launchUrl(timetablesURL,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $timetablesURL');
  }
}
